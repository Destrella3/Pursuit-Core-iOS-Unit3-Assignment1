import UIKit

class UserDetailViewController: UIViewController {

    var user: UserInfo!
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEMail: UILabel!
    @IBOutlet weak var userCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    userName.text = user.name.fullName
    userEMail.text = user.email
    userCity.text = user.location.city.capitalized
        do {
           let imageData = try Data(contentsOf: user.picture.large)
            userPicture.image = UIImage.init(data: imageData)
        } catch {
            print("Error: \(error)")
     }
   }
}

