import UIKit

enum ClassesState {
    case noData
    case loaded
}

class ProfileScreenView: UIView {
    
    var user = User()
    
    var classes: [DailyClasses]!
    
    var state: ClassesState = .noData {
        didSet {
            switch state {
            case .noData:
                emptyView.isHidden = false
                profileCardView.isHidden = true
                classesTableView.isHidden = true
            case .loaded:
                profileCardView.isHidden = false
                classesTableView.isHidden = false
                emptyView.isHidden = true
            }
        }
    }

    var onClassesChanged: (([DailyClasses])->())?
    
    var emptyView = EmptyView.loadFromNib()
  
    lazy var profileCardView: UIView = {
        var view = CardView.init()
        view.backgroundColor = Colors.background
        view.update(user: self.user)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var classesTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Colors.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ClassesTableViewCell.self, forCellReuseIdentifier: ClassesTableViewCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.background
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        if classes.isEmpty {
            state = .noData
        } else {
            state = .loaded
        }
    }
}

//MARK: - Layout configuration
extension ProfileScreenView {
    
    func setupViews() {
        self.backgroundColor = Colors.background
        self.addSubview(emptyView)
        self.addSubview(profileCardView)
        self.addSubview(classesTableView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            emptyView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            profileCardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileCardView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileCardView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            classesTableView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: 10),
            classesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            classesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            classesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}

//MARK: - Data Source
extension ProfileScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassesTableViewCell.reuseId, for: indexPath) as! ClassesTableViewCell
        
        let lesson = classes[indexPath.row]
        cell.update(lesson, index: indexPath.row)
        cell.deleteView.addTarget(self, action: #selector(lessonDeleted), for: .valueChanged)
        return cell
    }
    
    @objc func lessonDeleted(counter: DeleteView, indexPath: IndexPath) {
        classes[counter.index].count = counter.currentValue
        print(classes[counter.index].count)
        if counter.currentValue == 0 {
            print(counter.index)
            classes.remove(at: counter.index)
        }
        onClassesChanged?(classes)
    }
}
