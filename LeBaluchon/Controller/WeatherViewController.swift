//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 19/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import SVProgressHUD

class WeatherViewController: UIViewController {
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        SVProgressHUD.loader(shown: true)
        callWeatherService(for: .paris)
    }

    private func callWeatherService(for city: Cities) {
        WeatherService.shared.getWeather(for: city) { [weak self] success, weather in
            guard let self = self else { return }

            if success, let weather = weather {
                print("city: \(weather.name)")
                print("weather description: \(weather.weather[0].weatherDescription)")
                print("weather temperature: \(weather.main.temp)")
                if city != .newYork {
                    self.callWeatherService(for: .newYork)
                } else {
                    SVProgressHUD.loader(shown: false)
                }
            } else {
                self.presentAlert(title: "Petit problème",
                                  message: "OpenWeather n'a pas répondu.\nVeuillez réessayer.")
            }
        }
    }

}
