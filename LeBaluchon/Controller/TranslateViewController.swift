//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 19/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var changeDestinationLanguageButton: UIButton!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var changeLanguagePickerView: UIPickerView!
    
    // MARK: - Action
    @IBAction func openPickerWithLanguages() {
        print("openPickerWithLanguages button touched")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("TranslateViewController loaded")
    }

}
