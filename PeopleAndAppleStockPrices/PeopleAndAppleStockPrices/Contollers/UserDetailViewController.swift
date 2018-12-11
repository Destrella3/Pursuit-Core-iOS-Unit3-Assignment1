import UIKit

class UserDetailViewController: UIViewController {

    var user: UserInfo!
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEMail: UILabel!
    @IBOutlet weak var userCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    userName.text = user.name.first.capitalized + " " + user.name.last.capitalized
    userEMail.text = user.email
    userCity.text = user.location.city.capitalized
        
    }
}
