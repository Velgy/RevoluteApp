//
//  Service.swift
//  RevolutApp
//
//  Created by Валентин Панин on 09.02.2021.
//

import Foundation

class Service {

    func loadJson(fileName: String) -> [String]? {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            return nil
        }
            do {
                let data = try Data(contentsOf: url)
                    let country = try decoder.decode([String].self, from: data)
                return country
                
            } catch {
                print(error)
            }
        return nil
    }
}
