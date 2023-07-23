import UIKit

class ProfileScreenVC: UIViewController {
    
    var profileView: ProfileScreenView {
        return self.view as! ProfileScreenView
    }
    
    var classesArchiver = ClassesRepositoryImpl()
    
   lazy var classes: [DailyClasses] = classesArchiver.retrive()
    
    override func loadView() {
        self.view = ProfileScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        profileView.onClassesChanged = {
            let classes = self.profileView.classes
            self.classesArchiver.save(classes)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        profileView.classes = classesArchiver.retrive()
        profileView.classesTableView.reloadData()
    }
}
