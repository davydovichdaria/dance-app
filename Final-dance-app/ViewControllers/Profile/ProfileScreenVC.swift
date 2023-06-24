import UIKit

class ProfileScreenVC: UIViewController {
    
    private var profileScreenView: ProfileScreenView {
        return self.view as! ProfileScreenView
    }
    
    override func loadView() {
        self.view = ProfileScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }
    
    
}
