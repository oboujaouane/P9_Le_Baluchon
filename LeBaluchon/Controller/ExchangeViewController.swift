//
//  ExchangeViewController.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 19/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import SVProgressHUD

class ExchangeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var euroTextfield: UITextField!
    @IBOutlet private weak var usdLabel: UILabel!

    // MARK: - Function
    private func callExchangeRateService(amount: Decimal) {
        SVProgressHUD.loader(shown: true)
        ExchangeRateService.shared.getExchangeRate { [weak self] success, exchangeRate in
            guard let self = self else { return }

            if success, let exchangeRate = exchangeRate {
                var amountInUSD = amount * exchangeRate.rates.usd
                var amountInUSDrounded: Decimal = Decimal()
                NSDecimalRound(&amountInUSDrounded, &amountInUSD, 2, .plain)
                self.usdLabel.text = "\(amountInUSDrounded)"
                SVProgressHUD.loader(shown: false)
            } else {
                self.presentAlert(title: "Petit problème",
                                  message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
            }
        }
}

    // MARK: - Actions
    @IBAction func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func convertButtonTouched() {
        hideKeyboard()

        if let amountToExchange = euroTextfield.text, !amountToExchange.isEmpty {
            callExchangeRateService(amount: Decimal(string: amountToExchange)!)
        } else {
            self.presentAlert(title: "Petit problème",
                              message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
        }
    }
}

extension ExchangeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // Limit the textfield entry to two decimal
        guard let oldText = textField.text, let range = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: range, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}
