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
class FixerExchangeRate {
    // MARK: - Properties
    static private let endpoint = "http://data.fixer.io/api/latest"
    static private var parameters: String {
        return "?symbols=USD"
    }
    static private let accessKey = "&access_key=\(APIKeys.FixerExchangeRate)"

    static var url: String {
        return FixerExchangeRate.endpoint + FixerExchangeRate.parameters + FixerExchangeRate.accessKey
    }
}

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
