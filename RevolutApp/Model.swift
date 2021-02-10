//
//  Model.swift
//  RevolutApp
//
//  Created by Валентин Панин on 23.01.2021.
//

import Foundation
import RealmSwift

class Model: Object {
    
    @objc dynamic var firstCountry: String = ""
    @objc dynamic var secondCountry: String = ""
    @objc dynamic var course: Double = 1.0
    @objc dynamic var id: String = ""
    @objc dynamic var data = Date().timeIntervalSince1970
    
    var firstFullName: String? {
        let locale1 = Locale(identifier: firstCountry)
        return locale1.localizedString(forCurrencyCode: firstCountry)
    }
    
    var secondFullName: String? {
        let locale1 = Locale(identifier: secondCountry)
        return locale1.localizedString(forCurrencyCode: secondCountry)
    }
    
    convenience init(firstCountry: String, secondCountry: String, course: Double) {
        self.init()
        self.firstCountry = firstCountry
        self.secondCountry = secondCountry
        self.course = course
        self.id = ("\(firstCountry)\(secondCountry)")
    }
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


