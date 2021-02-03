//
//  Model.swift
//  RevolutApp
//
//  Created by Валентин Панин on 23.01.2021.
//

import Foundation

struct Model {
    let firstCountry: String
    let secondCountry: String
    let course: Double
    var firstFullName: String? {
        let locale1 = Locale(identifier: firstCountry)
        return locale1.localizedString(forCurrencyCode: firstCountry)
    }
    var secondFullName: String? {
        let locale1 = Locale(identifier: secondCountry)
        return locale1.localizedString(forCurrencyCode: secondCountry)
    }
}


