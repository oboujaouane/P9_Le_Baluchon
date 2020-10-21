//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

class WeatherService {
    // MARK: - Properties
    static var shared = WeatherService()
    private init() {}
    private var task: URLSessionDataTask?

    private var weatherSession = URLSession(configuration: .default)
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

    // MARK: - Function
    func getWeather(for city: Cities, callback: @escaping (Bool, EntireWeather?) -> Void) {
        OpenWeather.city = city.rawValue
        var request = URLRequest(url: URL(string: OpenWeather.url)!)
        request.httpMethod = HTTPMethod.get.rawValue

        task?.cancel()
        task = weatherSession.dataTask(with: request) { data, response, error in // dependency injection
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(EntireWeather.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
