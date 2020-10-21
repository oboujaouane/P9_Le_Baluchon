//
//  Translate.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 20/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

/*
Translate WS returns:
 {
     "data": {
         "translations": [
             {
                 "translatedText": "Hello how are you?"
             }
         ]
     }
 }
*/

/**
 Reflect the Google Translation API response body JSON structure to decode Google response
*/
struct Translate: Codable {
    let data: Translations

    struct Translations: Codable {
        var translations: [TranslatedText]
        // swiftlint:disable nesting
        struct TranslatedText: Codable {
            var translatedText: String
        }
    }
}
