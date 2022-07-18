//
//  Products.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import Foundation

class Product {
    let id: String
    let count: String
    let price: String
    let name: String
    let imageURL: String
    
    init(id: String, count: String, name: String, price: String, imageURL: String) {
        self.id = id
        self.count = count
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
}
