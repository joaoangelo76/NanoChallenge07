//
//  Model.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import Foundation

struct Coins: Codable{
    var quotes: [String: Float]
}

struct CurrenciesName: Codable{
    var currencies: [String: String]
}


