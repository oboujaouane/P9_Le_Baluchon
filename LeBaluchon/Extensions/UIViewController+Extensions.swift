//
//  UIViewController+Extensions.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     - Parameters:
        - title: The alert's title
        - message: The error message to be displayed
     */
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
