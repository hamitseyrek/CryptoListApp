//
//  ViewController.swift
//  CryptoListApp
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListviewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.currencyLabel.text = cryptoViewModel.name
        cell.priceLabel.text = cryptoViewModel.price
        return cell
    }
    
    func getData() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        WebService().downloadCurrency(url: url) { cryptoList in
            if let cryptoList = cryptoList {
                self.cryptoListViewModel = CryptoListviewModel(cryptoCurrencyList: cryptoList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

