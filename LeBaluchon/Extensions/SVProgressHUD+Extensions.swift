//
//  SVProgress.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    static func loader(shown: Bool) {
        DispatchQueue.main.async {
            if shown {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}
