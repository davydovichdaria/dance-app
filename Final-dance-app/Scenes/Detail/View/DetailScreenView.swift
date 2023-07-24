import UIKit
import CalendarKit

class DetailScreenView: UIView {
    
    var onSignUpButtonTapped: (()->())?
    
    lazy private var detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = Colors().background
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var detailStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var styleImageView: UIImageView = {
        var imageView = UIImageView.init()
        imageView.image = UIImage(named: "High Heels")
        imageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.5).isActive = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var infoClassesView = InfoClassesView.init()
    
    private var trainerDetailView = TrainerDetailView.init()
    
    private var signUpView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.widthAnchor.constraint(equalToConstant: Screen.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: 75).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sing up for a workout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "dark purple")
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 50, bottom: 5, right: 50)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func signUpButtonTapped() {
        onSignUpButtonTapped?()
    }
    
//MARK: - Public
    func update(currentClass: Schedule, day: DayViewState) {
            infoClassesView.update(currentClass, day: day)
            trainerDetailView.update(currentClass)
            styleImageView.image = UIImage(named: currentClass.name)
    }
}

//MARK: - Layout configuration
extension DetailScreenView {
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailStackView)
        
        detailStackView.addArrangedSubview(styleImageView)
        detailStackView.addArrangedSubview(infoClassesView)
        detailStackView.addArrangedSubview(trainerDetailView)
        
        self.addSubview(signUpView)
        signUpView.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            detailScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            detailScrollView.bottomAnchor.constraint(equalTo: signUpView.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: detailScrollView.topAnchor, constant: 0),
            detailStackView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor, constant: 0),
            detailStackView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor, constant: 0),
            detailStackView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0),
            detailStackView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0),
            signUpView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            signUpView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            signUpView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signUpView.topAnchor, constant: 15),
            signUpButton.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor, constant: -15),
            signUpButton.bottomAnchor.constraint(equalTo: signUpView.bottomAnchor, constant: -15)
        ])
    }
}
