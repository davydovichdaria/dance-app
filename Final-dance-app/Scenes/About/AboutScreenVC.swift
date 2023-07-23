import UIKit

class AboutScreenVC: UIViewController {
    
    private var aboutView: AboutScreenView {
        return self.view as! AboutScreenView
    }
    
    override func loadView() {
        self.view = AboutScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().background
    }  
}

