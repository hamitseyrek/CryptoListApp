//
//  ViewController.swift
//  CryptoListApp
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListviewModel!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        // In this case, we instantiate the banner with desired ad size.
        
        //MARK: - App Tracking Transparency
        NotificationCenter.default.addObserver(self, selector: #selector(requestIDFA), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    //MARK: - Google Admob Configuration
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    //MARK: - App Tracking Transparency
    @objc func requestIDFA() {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
        // loadAd()
          if status == .authorized {
              print("auth")
              
              DispatchQueue.main.async {
                  //MARK: - Google Admob Configuration
                  self.bannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(300))
                  self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
                  self.bannerView.rootViewController = self
                  self.bannerView.delegate = self
                  self.bannerView.load(GADRequest())
                  self.addBannerViewToView(self.bannerView)
              }
              
          } else if status == .denied {
              print("denied")
          } else {
              print("else")
          }
      })
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


// ca-app-pub-3940256099942544/2934735716
