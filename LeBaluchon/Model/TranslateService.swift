//
//  TranslateService.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 20/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

class TranslateService {
    static func getTranslation(with text: String) {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = GoogleTranslation.url + encodedText!

        var request = URLRequest(url: URL(string: completeURL)!)
        request.httpMethod = HTTPMethod.post.rawValue

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) {
                        print(responseJSON)
                    }
                }
            }
        }
        task.resume()
    }
}

/*
 POST -> https://translation.googleapis.com/language/translate/v2?key=AIzaSyBoSAy-NccJMmydIsl1B02hUxhc9HpNvf8

 Content-Type: application/json
 Accept-Charset: utf-8
 
 body JSON example :
 
 {
   "q": ["Bonjour comment allez-vous ?"],
   "source": "fr",
   "target": "en"
 }
*/
