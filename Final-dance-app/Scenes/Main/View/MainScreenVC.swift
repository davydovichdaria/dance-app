import UIKit

final class MainScreenVC: UIViewController {
    
    
    var classesArchiver = ClassesRepositoryImpl()
    lazy var futureClasses: [DailyClasses] = classesArchiver.retrive()        {
        didSet {
            classesCollectionView.reloadData()
        }
    }
    
    
    private let menuScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = Colors().background
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let menuStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var cardView = CardView()
    private let classesLabel = Label(style: .title, text: "My classes")
    var noClassesView = NoClassesView()
    
    lazy var classesCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 100)
        layout.itemSize = CGSize(width: Screen.width * 0.8, height: Screen.width * 0.3)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal

        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors().background
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ClassesCollectionViewCell.self, forCellWithReuseIdentifier: ClassesCollectionViewCell.reuseId)
        collectionView.heightAnchor.constraint(equalToConstant: Screen.width * 0.35).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let qwinersLabel = Label(style: .title, text: "Qwiners dance studio")
    private let aboutStudioView: UIView = {
        let view = InfoView(image: "star.circle.fill", color: "azure", label: "About studio", description: "Information about us, contact information and phone numbers")
        view.aboutButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let trainersView: UIView = {
        let view = InfoView(image: "figure.walk.circle.fill", color: "orange", label: "Trainers", description: "List of all the coaches of our club")
        view.aboutButton.addTarget(self, action: #selector(trainersButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        createCustomNavigationBar()
        
        let menuNavigationView = createCustomTitleView(image: "Studio label")
        navigationItem.titleView = menuNavigationView
        
        noClassesView.onScheduleButtonAction = {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        futureClasses = classesArchiver.retrive()
        setupViews()
        classesCollectionView.reloadData()
    }

    @objc func aboutButtonTapped() {
        self.navigationController?.pushViewController(AboutScreenVC(), animated: true)
    }
    
    @objc func trainersButtonTapped() {
        self.navigationController?.pushViewController(TrainersScreenVC(), animated: true)
    }
    
    
    func showClassesView() {
        if futureClasses.count != 0 {
//            menuStackView.removeArrangedSubview(noClassesView)
            noClassesView.isHidden = true
            classesCollectionView.isHidden = false

        } else { menuStackView.addArrangedSubview(noClassesView)
//            menuStackView.removeArrangedSubview(classesCollectionView)
            
            noClassesView.isHidden = false
            classesCollectionView.isHidden = true
        }
    }
}

//MARK: - Layout configuration


extension MainScreenVC {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(menuScrollView)
        menuScrollView.addSubview(menuStackView)
        menuStackView.addArrangedSubview(cardView)
        menuStackView.addArrangedSubview(classesLabel)
        menuStackView.addArrangedSubview(noClassesView)
        menuStackView.addArrangedSubview(classesCollectionView)
        showClassesView()
        menuStackView.addArrangedSubview(qwinersLabel)
        menuStackView.addArrangedSubview(aboutStudioView)
        menuStackView.addArrangedSubview(trainersView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            menuScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            menuScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            menuScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            menuScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: menuScrollView.topAnchor, constant: 0),
            menuStackView.leadingAnchor.constraint(equalTo: menuScrollView.leadingAnchor, constant: 0),
            menuStackView.trailingAnchor.constraint(equalTo: menuScrollView.trailingAnchor, constant: 0),
            menuStackView.bottomAnchor.constraint(equalTo: menuScrollView.bottomAnchor, constant: 0),
            menuStackView.widthAnchor.constraint(equalTo: menuScrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            classesLabel.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor, constant: 15)
        ])
        

        
        NSLayoutConstraint.activate([
            qwinersLabel.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            aboutStudioView.topAnchor.constraint(equalTo: qwinersLabel.bottomAnchor, constant: 15)
        ])
    }
}

extension MainScreenVC:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return futureClasses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassesCollectionViewCell.reuseId, for: indexPath) as! ClassesCollectionViewCell
        let lesson = futureClasses[indexPath.row]
        cell.update(lesson)
        return cell
    }
}

