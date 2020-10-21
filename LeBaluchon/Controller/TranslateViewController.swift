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
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var changeDestinationLanguageButton: UIButton!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var changeLanguagePickerView: UIPickerView!

    // MARK: - Actions
    @IBAction func openPickerWithLanguages() {
        translateTextField.resignFirstResponder()
        changeLanguagePickerView.isHidden = false
    }

    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Functions
    private func update(translationText: String) {
        translationTextView.text = translationText
    }

    private func loader(shown: Bool) {
        DispatchQueue.main.async {
            if shown {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension TranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loader(shown: true)

        if let textToTranslate = translateTextField.text {
            TranslateService.shared.getTranslation(with: textToTranslate) { [weak self] success, translatedText in
                guard let self = self else { return }

                self.loader(shown: false)
                if success, let translatedText = translatedText {
                    self.update(translationText: translatedText)
                } else {
                    self.presentAlert()
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }

    // TODO: relocate
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Petit problème",
                                        message: "Google traduction n'a pas répondu.\nVeuillez réessayer.",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
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
        changeDestinationLanguageButton.setTitle(currentLanguageSelected.name, for: .normal)
        changeLanguagePickerView.isHidden = true
    }
}
