import UIKit

class TrainersCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "TrainersCollectionViewCell"
    
    private var containerView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalCentering
        view.heightAnchor.constraint(equalToConstant: Screen.width * 0.35).isActive = true
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white.withAlphaComponent(0.95)
        
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.05)
        return view
    }()
    
    var trainerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Veronica")
        imageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.34).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Screen.width * 0.34).isActive = true
        imageView.layer.cornerRadius = Screen.width * 0.17
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    var nameLabel = Label(style: .trainerName, text: "Veronica")
    
    var typeOfClassesLabel = Label(style: .descriptionSmall, text: "Girly Choreo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        self.layer.cornerRadius = 18
        self.layer.shadowOpacity = 1.3
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        
        self.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Public
    func update(_ trainers: Trainer) {
        trainerImageView.image = UIImage(named: trainers.name)
        nameLabel.text = trainers.name
        typeOfClassesLabel.text = trainers.typeOfClass
    }
}

//MARK: - Layout configuration
extension TrainersCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.addArrangedSubview(trainerImageView)
        containerView.addArrangedSubview(nameLabel)
        containerView.addArrangedSubview(typeOfClassesLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            trainerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            
        ])
        
        NSLayoutConstraint.activate([
            typeOfClassesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            typeOfClassesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            
        ])
    }
}
