import UIKit

class ProfileScreenVC: UIViewController {
    
    var profileProvider: ProfileProvider
    
    var profileView: ProfileScreenView {
        return self.view as! ProfileScreenView
    }
    
    init(profileProvider: ProfileProvider) {
        self.profileProvider = profileProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ProfileScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomNavigationBar()
        title = "Profile"
        
        profileView.emptyView.onScheduleButtonTapped = {
            self.tabBarController?.selectedIndex = 1
        }
        
        profileView.classes = profileProvider.loadClasses()
        profileView.update()
        profileView.onClassesChanged = { classes in
            self.profileProvider.saveClasses(classes: classes)
            self.profileView.classesTableView.reloadData()
            self.profileView.update()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileView.classes = profileProvider.loadClasses()
        profileView.classesTableView.reloadData()
        profileView.update()
    }
}
