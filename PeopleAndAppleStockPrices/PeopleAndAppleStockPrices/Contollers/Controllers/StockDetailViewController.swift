//
//  AppleStockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Diego Estrella III on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    var stock: AppleStock!
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStockData()
    }
    
    func updateStockData() {
        stockDate.text = stock.date
        stockOpen.text = String(format: "Open: %.2f", stock.open)
        stockClose.text = String(format: "Close: %.2f", stock.close)
        if stock.close > stock.open {
            view.backgroundColor = .green
            stockImage.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = .red
            stockImage.image = UIImage(named: "thumbsDown")
        }
    }
}
