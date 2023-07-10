import UIKit

final class MainScreenVC: UIViewController {
    
    private let menuScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray.withAlphaComponent(0.1)
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
    var classesView = ClassesView()
    private let qwinersLabel = Label(style: .title, text: "Qwiners dance studio")
    private let aboutStudioView: UIView = {
        let view = InfoView(image: "Default profile", label: "About studio", description: "Information about us, contact information and phone numbers")
        view.aboutButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let trainersView: UIView = {
        let view = InfoView(image: "Default profile", label: "Trainers", description: "List of all the coaches of our club")
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
        
        classesView.onScheduleButtonAction = {
            self.tabBarController?.selectedIndex = 1
        }
    }

    @objc func aboutButtonTapped() {
        self.navigationController?.pushViewController(AboutScreenVC(), animated: true)
    }
    
    @objc func trainersButtonTapped() {
        self.navigationController?.pushViewController(TrainersScreenVC(), animated: true)
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
        menuStackView.addArrangedSubview(classesView)
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
            classesView.topAnchor.constraint(equalTo: classesLabel.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            qwinersLabel.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            aboutStudioView.topAnchor.constraint(equalTo: qwinersLabel.bottomAnchor, constant: 15)
        ])
    }
}


