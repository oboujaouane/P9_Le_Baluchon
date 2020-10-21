//
//  ServicesURLs.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 20/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

/// List of methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// Webservices used
enum WebService {
    case fixer, googleTranslation, yahooWeather
}

// MARK: - Fixer
// TODO

// MARK: - Google Translation

class GoogleTranslation {
    // MARK: - Properties
    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(APIKeys.GoogleTranslation)"
    static private var parameters: String {
        return "&source=fr&target=\(Languages.currentLanguageCodeISO)&format=text&q="
    }
    static var url: String {
        return GoogleTranslation.endpoint + GoogleTranslation.accessKey + GoogleTranslation.parameters
    }
}

// MARK: - Yahoo Weather
// TODO
