//
//  String+Extensions.swift
//  LeBaluchon
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
