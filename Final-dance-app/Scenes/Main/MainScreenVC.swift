import UIKit

final class MainScreenVC: UIViewController {
    
    var mainView: MainScreenView {
        return self.view as! MainScreenView
    }
    
    let mainProvider: MainProvider
    
    init(provider: MainProvider) {
        self.mainProvider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = MainScreenView.init(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createCustomNavigationBar()
        
        let menuNavigationView = createCustomTitleView(image: "Studio label")
        navigationItem.titleView = menuNavigationView
        
        mainView.update(mainProvider.repository.retrive())
        
        mainView.showClassesView(mainProvider.repository.retrive())
        
        mainView.noClassesView.onScheduleButtonAction = {
            self.tabBarController?.selectedIndex = 1
        }
        
        mainView.onAboutButtonTapped = {
            self.navigationController?.pushViewController(Di.shared.screenFactory.makeAboutScreen(), animated: true)
        }
        
        mainView.onTrainersButtonTapped = {
            self.navigationController?.pushViewController(Di.shared.screenFactory.makeTrainerScreen(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let futureClasses = mainProvider.repository.retrive()
        mainView.update(futureClasses)
        mainView.showClassesView(futureClasses)
        mainView.classesCollectionView.reloadData()
    }
}
