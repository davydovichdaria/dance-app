import UIKit

class TrainersScreenVC: UIViewController {
    
    private var trainersAPI: TrainersApiClient
    
    var trainersView: TrainersScreenView {
        return self.view as! TrainersScreenView
    }
    
    init(trainersAPI: TrainersApiClient) {
        self.trainersAPI = trainersAPI
        
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
        
        fetchTrainers(endpoint: TrainersEndpoint.getTrainers)
        
        trainersView.onScheduleButtonTapped = {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    func fetchTrainers(endpoint: Endpoint) {
        
        trainersAPI.fetchSchedule(endpoint: endpoint) { result in
            switch result {
            case .success(let trainers):
                self.trainersView.trainers = trainers
                self.trainersView.trainersTableView.reloadData()
            case .failure(_):
                print("Error")
            }
        }
    }
}
