//
//  ViewModel.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import Foundation
class ViewModel: ObservableObject{
    
    let apiManager = APIManager()
    
    let codeAndName = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/list.json"
    let codeAndQuotation = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json"
    
    @Published var coins: [String : Float]?
    @Published var currenciesNames: [String : String]?
    
    init(){
        fetchCurrencies()
        fetchCoins()
    }
    
    func fetchCurrencies(){
        Task {
            let result = await apiManager.fetch(httpLink: codeAndName, object: CurrenciesName(currencies: ["":""]))
            switch result {
            case .success(let decodedObject):
                self.currenciesNames = decodedObject.currencies
                print(decodedObject.currencies)
            case .failure(let error):
                switch error {
                case .invalidURL:
                    print("Invalid URL.")
                case .networkError(let networkError):
                    print("Network error: \(networkError.localizedDescription)")
                case .decodingError(let decodingError):
                    print("Decoding error: \(decodingError.localizedDescription)")
                }
            }
        }
    }
    
    func fetchCoins(){
        Task {
            let result = await apiManager.fetch(httpLink: codeAndName, object: Coins(quotes: ["":0]))
            switch result {
            case .success(let decodedObject):
                self.coins = decodedObject.quotes
                print(decodedObject.quotes)
            case .failure(let error):
                switch error {
                case .invalidURL:
                    print("Invalid URL.")
                case .networkError(let networkError):
                    print("Network error: \(networkError.localizedDescription)")
                case .decodingError(let decodingError):
                    print("Decoding error: \(decodingError.localizedDescription)")
                }
            }
        }
    }
}
