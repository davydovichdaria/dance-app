import UIKit

final class MainScreenVC: UIViewController {
    
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
        
        mainScreenView.classesView.onScheduleButtonAction = {
            self.tabBarController?.selectedIndex = 1
        }
        
        mainScreenView.onAboutButtonTapped = {
            self.navigationController?.pushViewController(AboutScreenVC(), animated: true)
        }
        
        mainScreenView.onTrainersButtonTapped = {
            self.navigationController?.pushViewController(TrainersScreenVC(), animated: true)
        }

    }
    
    @objc func buttonTapped() {
        print("button tapped")
    }
    
}


