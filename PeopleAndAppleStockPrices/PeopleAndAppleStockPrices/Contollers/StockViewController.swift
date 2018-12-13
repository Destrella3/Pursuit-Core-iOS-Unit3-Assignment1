import UIKit

class StockViewController: UIViewController {

    var stocks = [AppleStock]()
    var stockMatrix = [[AppleStock]]()
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        loadData()
        title = "Stocks"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController,
            let cellSelected = stockTableView.indexPathForSelectedRow else { return }
            let userSelected = stocks[cellSelected.row]
            destination.stock = userSelected
        
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURl ) {
                do {
                    self.stocks = try JSONDecoder().decode([AppleStock].self, from: data)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "AppleStockCell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(format: "%.2f", stock.close)
        return cell
    }
}

extension StockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return ""
        
    }
}
