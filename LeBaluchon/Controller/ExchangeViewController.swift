//
//  ExchangeViewController.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 19/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import SVProgressHUD

class ExchangeViewController: UIViewController {
    // MARK: - Action
    @IBAction func touchCalculRate() {
        callExchangeRateService()
    }

    // MARK: - Function
    private func callExchangeRateService() {
        SVProgressHUD.loader(shown: true)
               ExchangeRateService.shared.getExchangeRate { [weak self] success, exchangeRate in
                   guard let self = self else { return }

                   if success, let exchangeRate = exchangeRate {
                       print(exchangeRate.rates.usd)
                       SVProgressHUD.loader(shown: false)
                   } else {
                       self.presentAlert(title: "Petit problème",
                                         message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
                   }
               }
    }
}
