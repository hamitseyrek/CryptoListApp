//
//  CryptoViewModel.swift
//  CryptoListApp
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation

struct CryptoListviewModel {
    let cryptoCurrencyList : [CryptoCurrency]
}

extension CryptoListviewModel {
    func numberOfRowsInSection() -> Int {
        self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(_ index : Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
}

struct CryptoViewModel {
    let cryptoCurrency : CryptoCurrency
    var name : String {
        self.cryptoCurrency.currency
    }
    var price :String {
        self.cryptoCurrency.price
    }
}
