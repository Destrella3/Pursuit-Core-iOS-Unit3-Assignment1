import UIKit

class UserViewController: UIViewController {

    var user = [UserInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    userTableView.dataSource = self
    userSearchBar.delegate = self
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController,
            let cellSelected = userTableView.indexPathForSelectedRow else { return }
            let userSelected = user[cellSelected.row]
            destination.user = userSelected
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURl ) {
                do {
                    let newUser = try JSONDecoder().decode(User.self, from: data)
                    user = newUser.results.sorted(by: {$0.name.first < $1.name.first})
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let users = user[indexPath.row]
        let userName = users.name
        cell.textLabel?.text = (userName.title.capitalized + " " + userName.first.capitalized + " " + userName.last.capitalized)
        let userLocation = users.location
        cell.detailTextLabel?.text = userLocation.city.capitalized
        return cell
        
    }
}

extension UserViewController: UISearchBarDelegate {
    
}
