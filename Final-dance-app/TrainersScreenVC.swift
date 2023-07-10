import UIKit
import Combine

enum Section: Int, CaseIterable {
    case trainers
    case contacts
}

class TrainersScreenVC: UIViewController {
    
    //MARK: - MVVM
    
    private var viewModel = TrainersViewModel.init()
    private var viewSignal = PassthroughSubject<TrainersViewModel.ViewSignal, Never>()
    private var subscribtion = Set<AnyCancellable>()
    
    var trainers: [Trainer] = []
    var onScheduleButtonTapped: (()->())?

    lazy var trainersTableView: UITableView = {
        var tableView = UITableView()
        
        tableView.backgroundColor = Colors().background
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TrainersTableViewCell.self, forCellReuseIdentifier: TrainersTableViewCell.reuseID)
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        bind()
        viewSignal.send(.initialLoading)
        
        self.onScheduleButtonTapped = {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    public func bind() {
        let output = viewModel.bind(signal: viewSignal.eraseToAnyPublisher())
        
        output.trainers
            .receive(on: RunLoop.main)
            .sink { trainers in
                self.trainers = trainers
                self.trainersTableView.reloadData()
            }
            .store(in: &subscribtion)
    }
}

//MARK: - Layout configuration
extension TrainersScreenVC {
    
    func setupViews() {
        view.backgroundColor = .white
        title = "Trainers"
        view.addSubview(trainersTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trainersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            trainersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            trainersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            trainersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

//MARK: - Table View
extension TrainersScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.init(rawValue: indexPath.section)
        
        switch section {
        case .trainers:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainersTableViewCell.reuseID, for: indexPath) as! TrainersTableViewCell
            print(trainers.count)
            cell.update(trainers)
            cell.trainersCollectionView.reloadData()
            return cell
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.reuseID, for: indexPath) as! ContactsTableViewCell
            cell.onScheduleButtonTapped = {
                self.onScheduleButtonTapped?()
            }
            return cell
        default: return UITableViewCell()
        }
    }
}
