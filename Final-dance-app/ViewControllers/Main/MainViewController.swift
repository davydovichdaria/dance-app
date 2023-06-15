import UIKit

final class MainViewController: UIViewController {
    
    private var mainScreenView: MainScreenView {
        return self.view as! MainScreenView
    }
    
    override func loadView() {
        self.view = MainScreenView(frame: Screen.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomNavigationBar()
        
        let notificationButton = createCustomButton(imageName: "bell", selector: #selector(buttonTapped))
        let menuNavigationView = createCustomTitleView(image: "Studio label")
        
        navigationItem.rightBarButtonItem = notificationButton
        navigationItem.titleView = menuNavigationView
    }
    
    @objc func buttonTapped() {
        print("button tapped")
    }
}


