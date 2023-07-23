import UIKit

class MainTabVC: UITabBarController {
    
    var di = Di()
    
    lazy private var mainVC: UINavigationController = {
        
        let controller = Di.shared.screenFactory.makeMainScreen()
        
        let navigationController = UINavigationController(rootViewController: controller)
        
        let image = UIImage(systemName: "house.fill")
        let selectedImage = UIImage(systemName: "house.fill")
        let tabItem = UITabBarItem.init(title: "Main", image: image, selectedImage: selectedImage)
        navigationController.tabBarItem = tabItem
        return navigationController
    }()
    
    private var scheduleVC: UINavigationController = {
        
        let controller = Di.shared.screenFactory.makeScheduleScreen()
        
        let navigationController = UINavigationController(rootViewController: ScheduleScreenVC())
        
        let image = UIImage(systemName: "clock")
        let selectedImage = UIImage(systemName: "clock")
        let tabItem = UITabBarItem.init(title: "Schedule", image: image, selectedImage: image)
        navigationController.tabBarItem = tabItem
        return navigationController
    }()
    
    private var profileVC: UINavigationController = {
        
        let controller = Di.shared.screenFactory.makeProfileScreen()
        
        let navigationController = UINavigationController(rootViewController: ProfileScreenVC())
        
        let image = UIImage(systemName: "person.crop.circle")
        let selectedImage = UIImage(systemName: "person.crop.circle")
        let tabItem = UITabBarItem.init(title: "Profile", image: image, selectedImage: image)
        navigationController.tabBarItem = tabItem
        return navigationController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewControllers = [mainVC, scheduleVC, profileVC]
    }
    
    private func setup() {
        tabBar.tintColor = #colorLiteral(red: 0.580648005, green: 0.4500836134, blue: 1, alpha: 1)
        tabBar.backgroundColor = .white
    }
}
