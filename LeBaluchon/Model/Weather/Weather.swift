//
//  Translate.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 20/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

/**
 Reflect the OpenWeather API response body JSON structure to decode Weather response
*/
// MARK: - Welcome
struct EntireWeather: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let weatherId: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case main
        case weatherDescription = "description"
        case icon
    }
}
