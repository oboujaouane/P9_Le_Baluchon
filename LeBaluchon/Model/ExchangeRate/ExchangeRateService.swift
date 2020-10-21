//
//  ExchangeRateService.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

class ExchangeRateService {
    // MARK: - Properties
    static var shared = ExchangeRateService()
    private init() {}
    private var task: URLSessionDataTask?

    private var exchangeRateSession = URLSession(configuration: .default)
    init(exchangeRateSession: URLSession) {
        self.exchangeRateSession = exchangeRateSession
    }

    // MARK: - Function
    func getExchangeRate(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        var request = URLRequest(url: URL(string: FixerExchangeRate.url)!)
        request.httpMethod = HTTPMethod.get.rawValue

        task?.cancel()
        task = exchangeRateSession.dataTask(with: request) { data, response, error in // dependency injection
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
