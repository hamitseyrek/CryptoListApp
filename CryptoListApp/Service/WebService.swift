//
//  WebService.swift
//  CryptoListApp
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation

class WebService {
    
    func downloadCurrency(url : URL, completion : @escaping ([CryptoCurrency]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                completion(nil)
            } else if let data = data {
                do {
                   let cryptoList =  try JSONDecoder().decode([CryptoCurrency].self, from: data)
                    completion(cryptoList)
                } catch {
                    
                }
            }
        }.resume()
    }
}
