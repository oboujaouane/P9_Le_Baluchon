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

// MARK: - Weather
class OpenWeather {
    // MARK: - Properties
    static private let endpoint = "https://api.openweathermap.org/data/2.5/weather"
    static private var parameters: String {
        return "?units=metric&id=\(city)&lang=fr" // Get Celsius instead of Fahrenheit for city of New York
    }
    static private let accessKey = "&appid=\(APIKeys.OpenWeather)"

    static var city = ""
    static var url: String {
        return OpenWeather.endpoint + OpenWeather.parameters + OpenWeather.accessKey
    }
}
