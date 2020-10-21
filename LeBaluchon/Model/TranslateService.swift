//
//  TranslateService.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 20/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

class TranslateService {
    // MARK: - Properties
    static var shared = TranslateService()
    private init() {}
    private var task: URLSessionDataTask?
    
    // MARK: - Function
    func getTranslation(with text: String, callback: @escaping (Bool, String?) -> Void) {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = GoogleTranslation.url + encodedText!

        var request = URLRequest(url: URL(string: completeURL)!)
        request.httpMethod = HTTPMethod.post.rawValue

        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, responseJSON.data.translations[0].translatedText)
            }
        }
        task?.resume()
    }
}

/*
 
 Content-Type: application/json
 Accept-Charset: utf-8
 
 body JSON example :
 
 {
 "q": ["Bonjour comment allez-vous ?"],
 "source": "fr",
 "target": "en"
 }
 */
