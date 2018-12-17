import UIKit

class StockDetailViewController: UIViewController {
    var stock: [AppleStock]!
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStockData()
    }
    
    func updateStockData() {
        let stocks = stock[0]
        stockDate.text = stocks.date
        stockOpen.text = String(format: "Open: %.2f", stocks.open)
        stockClose.text = String(format: "Close: %.2f", stocks.close)
        if stocks.close > stocks.open {
            view.backgroundColor = .green
            stockImage.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = .red
            stockImage.image = UIImage(named: "thumbsDown")
        }
    }
}
