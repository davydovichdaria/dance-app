import UIKit

final class MainScreenView: UIView {
    
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
    private var classesView = ClassesView()
    
    private let qwinersLabel = Label(style: .title, text: "Qwiners dance studio")
    private let aboutStudioView = InfoView(image: "Default profile", label: "About studio", description: "Information about us, contact information and phone numbers")
    private let trainersView = InfoView(image: "Default profile", label: "Trainers", description: "List of all the coaches of our club")
    private let rentalView = InfoView(image: "Default profile", label: "Hall rental", description: "You can rent a hall in our studio")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
        menuStackView.widthAnchor.constraint(equalTo: menuScrollView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainScreenView {
    private func setupViews() {
        
        self.addSubview(menuScrollView)
        menuScrollView.addSubview(menuStackView)

        menuStackView.addArrangedSubview(cardView)
        menuStackView.addArrangedSubview(classesLabel)
        menuStackView.addArrangedSubview(classesView)
        menuStackView.addArrangedSubview(qwinersLabel)
        menuStackView.addArrangedSubview(aboutStudioView)
        menuStackView.addArrangedSubview(trainersView)
        menuStackView.addArrangedSubview(rentalView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            menuScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            menuScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            menuScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            menuScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: menuScrollView.topAnchor, constant: 0),
            menuStackView.leadingAnchor.constraint(equalTo: menuScrollView.leadingAnchor, constant: 0),
            menuStackView.trailingAnchor.constraint(equalTo: menuScrollView.trailingAnchor, constant: 0),
            menuStackView.bottomAnchor.constraint(equalTo: menuScrollView.bottomAnchor, constant: 0)
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
