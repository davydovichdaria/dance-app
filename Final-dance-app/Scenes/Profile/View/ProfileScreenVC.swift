import UIKit

class ProfileScreenVC: UIViewController {

    
    var classesArchiver = ClassesRepositoryImpl()
    lazy var classes: [DailyClasses] = classesArchiver.retrive() {
        didSet {
            classesTableView.reloadData()
        }
    }
    
    var profileCardView: UIView = {
        var view = CardView.init()
        view.cardImageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.25).isActive = true
        view.cardImageView.layer.cornerRadius = 15
        view.cardImageView.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var classesTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Colors().background
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ClassesTableViewCell.self, forCellReuseIdentifier: ClassesTableViewCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = Colors().background
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        classes = classesArchiver.retrive()
            classesTableView.reloadData()
    }
    
    func setupViews() {
        view.addSubview(profileCardView)
        view.addSubview(classesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            classesTableView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: 10),
            classesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            classesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            classesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    
    @objc func lessonDeleted(counter: DeleteView) {
        classes[counter.index].count = counter.currentValue
        
        if counter.currentValue == 0 {
            classes.remove(at: counter.index)
        }
        classesTableView.reloadData()
        classesArchiver.save(classes)
    }
    
    
}

extension ProfileScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassesTableViewCell.reuseId, for: indexPath) as! ClassesTableViewCell
        let lesson = classes[indexPath.row]
        
        
        cell.update(lesson)
        
        cell.deleteView.addTarget(self, action: #selector(lessonDeleted), for: .valueChanged)
        return cell
    }
}
