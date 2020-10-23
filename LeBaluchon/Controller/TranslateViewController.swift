//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 19/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import SVProgressHUD
import UIKit

class TranslateViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var translateTextField: UITextField!
    @IBOutlet private weak var changeDestinationLanguageButton: UIButton!
    @IBOutlet private weak var translationTextView: UITextView!
    @IBOutlet private weak var changeLanguagePickerView: UIPickerView!

    // MARK: - Actions
    @IBAction func openPickerWithLanguages() {
        translateTextField.resignFirstResponder()
        changeLanguagePickerView.isHidden = false
    }

    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Functions
    private func callTranslateService(with textToTranslate: String) {
        TranslateService.shared.getTranslation(with: textToTranslate) { [weak self] success, translatedText in
            guard let self = self else { return }

            SVProgressHUD.loader(shown: false)
            if success, let translatedText = translatedText {
                self.update(translationText: translatedText)
            } else {
                self.presentAlert(title: "Petit problème",
                                  message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
            }
        }
    }

    private func update(translationText: String) {
        translationTextView.text = translationText
    }
}

extension TranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SVProgressHUD.loader(shown: true)

        guard let textToTranslate = textField.text else {
            self.presentAlert(title: "Petit problème",
            message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
            return true
        }
        callTranslateService(with: textToTranslate)

        textField.resignFirstResponder()
        return true
    }
}

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Languages.list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Languages.list[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentLanguageSelected = Languages.list[row]
        Languages.currentLanguageCodeISO = currentLanguageSelected.codeISO

        guard let textToTranslate = translateTextField.text else {
            self.presentAlert(title: "Petit problème",
            message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
            return
        }
        callTranslateService(with: textToTranslate)

        changeDestinationLanguageButton.setTitle(currentLanguageSelected.name, for: .normal)
        changeLanguagePickerView.isHidden = true
    }
}
