import UIKit

class TrainersScreenVC: UIViewController {

    var trainersProvider: TrainersProvider
    
    var trainersView: TrainersScreenView {
        return self.view as! TrainersScreenView
    }
    
    init(trainersProvider: TrainersProvider) {
        self.trainersProvider = trainersProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = TrainersScreenView.init(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trainers"
        
        trainersProvider.fetchTrainers()
        
        trainersProvider.onTrainersLoaded = { trainers in
            self.trainersView.trainers = trainers
            self.trainersView.trainersTableView.reloadData()
        }
        
        trainersView.onScheduleButtonTapped = {
            self.tabBarController?.selectedIndex = 1
        }
    }
}
