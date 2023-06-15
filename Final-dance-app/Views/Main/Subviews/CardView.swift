import UIKit

final class CardView: UIView {
    
    private let cardImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Card")
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        imageView.layer.shadowColor = UIColor.blue.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowRadius = 11.0
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Default profile")
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    #warning("сделать экран регистрации и там принять данные")
    private var personNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Name Surname"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let studioNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Qwiners dance studio"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView {
    
    private func setupViews() {
        self.addSubview(cardImageView)
        self.addSubview(profileImageView)
        self.addSubview(personNameLabel)
        self.addSubview(studioNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            cardImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            cardImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            cardImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            personNameLabel.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 15),
            personNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            studioNameLabel.topAnchor.constraint(equalTo: personNameLabel.bottomAnchor, constant: 0),
            studioNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
    }
}
