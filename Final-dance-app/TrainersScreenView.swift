import UIKit

class TrainersScreenView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Section
extension TrainersScreenView {
    
    enum Section: Int, CaseIterable {
        case trainers
        case contacts
    }
}

//MARK: - Table View
extension TrainersScreenView: UITableViewDataSource, UITableViewDelegate {
    
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

//MARK: - Layout configuration
extension TrainersScreenView {
    
    func setupViews() {
        self.backgroundColor = .white
        self.addSubview(trainersTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trainersTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            trainersTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            trainersTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            trainersTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

