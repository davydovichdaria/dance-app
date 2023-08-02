import UIKit

final class TrainerDetailView: UIView {
    
    private var containerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.backgroundColor = Colors.background
        stackView.widthAnchor.constraint(equalToConstant: Screen.width).isActive = true
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let trainerLabel = Label(style: .typesOfClasses, text: "Trainer")
    
    private var trainerContainerView: UIStackView = {
     var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 25
        view.distribution = .fillProportionally
        view.widthAnchor.constraint(equalToConstant: Screen.width).isActive = true
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 20, trailing: -15)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.95)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = false
         return view
     }()
     
     var trainerImageView: UIImageView = {
         var imageView = UIImageView()
         imageView.image = UIImage(named: "Veronica")
         imageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.16).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: Screen.width * 0.16).isActive = true
         imageView.layer.cornerRadius = Screen.width * 0.08
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleAspectFill
         return imageView
     }()
    
    var infoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
     
     var nameLabel = Label(style: .trainerName, text: "Veronica")
     var typeOfClassesLabel = Label(style: .descriptionSmall, text: "Girly Choreo")
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ lesson: Schedule) {
        trainerImageView.image = UIImage(named: lesson.teacher)
        nameLabel.text = lesson.teacher
        typeOfClassesLabel.text = lesson.name
    }
    
     
     func setupViews() {
         
         self.addSubview(containerStackView)
         
         containerStackView.addArrangedSubview(trainerLabel)
         containerStackView.addArrangedSubview(trainerContainerView)
         
         trainerContainerView.addArrangedSubview(trainerImageView)
         trainerContainerView.addArrangedSubview(infoStackView)
         
         infoStackView.addArrangedSubview(nameLabel)
         infoStackView.addArrangedSubview(typeOfClassesLabel)
     }
     
     func setupConstraints() {
         
         NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
         ])
     }
}
