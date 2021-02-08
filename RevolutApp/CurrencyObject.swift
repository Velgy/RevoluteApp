//
//  CurrencyObject.swift
//  RevolutApp
//
//  Created by Валентин Панин on 08.02.2021.
//

import RealmSwift

@objcMembers
class CurrencyObject: Object {
    
    dynamic var currency: String = ""
    dynamic var id: String = UUID().uuidString
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
