import UIKit

class StockViewController: UIViewController {

    var stocks = [AppleStock]()
    var stockMatrix = [[AppleStock]]()
    
    

    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        stockMatrix = makeSections()
        title = "Stocks"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController,
            let cellSelected = stockTableView.indexPathForSelectedRow else { return }
            let userSelected = stockMatrix[cellSelected.row]
            destination.stock = userSelected
        
    }
    
    func getMonthYear(dateString: String) -> (month: String, year: String) {
        let components = dateString.components(separatedBy: "-")
        return (components[1], components[0])
    }
    
    private func makeSections() -> [[AppleStock]] {
        var stockPriceSections = [[AppleStock]]()
        if let stockResults = loadData() {
            stockPriceSections.append([AppleStock]())
            
            var startIndex = 0
            var date = (month: "12", year:"2016")
            
            
            for stockPrice in stockResults {
                if date != getMonthYear(dateString: stockPrice.date){
                    date = getMonthYear(dateString: stockPrice.date)
                    stockPriceSections.append([AppleStock]())
                    startIndex += 1
                }
                stockPriceSections[startIndex].append(stockPrice)
            }
        }
        return stockPriceSections
    }
    
    func loadData() -> [AppleStock]? {
        var stocks: [AppleStock]?
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURl ) {
                do {
                   stocks = try JSONDecoder().decode([AppleStock].self, from: data)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        return stocks
    }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockMatrix[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "AppleStockCell", for: indexPath)
        let stock = stockMatrix[indexPath.section][indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(format: "%.2f", stock.close)
        return cell
    }
}

extension StockViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockMatrix.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let monthDictionary = [01:"Jan", 02:"Feb", 03:"Mar", 04:"Apr", 05:"May", 06:"Jun", 07:"Jul", 08:"Aug", 09:"Sep", 10:"Oct", 11:"Nov", 12:"Dec" ]
        
        var stringToReturn = ""
        let accessToDateForSection = getMonthYear(dateString: stockMatrix[section][0].date)
        let sumOfMonthOpenPrice = stockMatrix[section].reduce(0){$0 + $1.open}
        let averageOfOpenPrice = sumOfMonthOpenPrice / Double(stockMatrix[section].count)
        
        for (key, value) in monthDictionary{
            if Int(accessToDateForSection.month) == key {
                stringToReturn = "\(accessToDateForSection.year) - \(value).      Average: $\(String(format: "%.2f", averageOfOpenPrice))"
            }
        }
        return stringToReturn
    }
}
