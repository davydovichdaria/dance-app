import UIKit

final class InfoView: UIView {
    
    private var infoImage: String
    private var infoLabel: String
    private var infoDescription: String
    
    private var aboutStudioContainer = InfoContainerStackView()
    
    private lazy var aboutStudioImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: infoImage)
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var aboutDescriptionContainer: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var aboutStudioLabel = Label(style: .title, text: infoLabel)
    private lazy var aboutStudioDespriptionLabel = Label(style: .descriptionSmall, text: infoDescription)
    private var aboutButton = Button(style: .chevron, text: "chevron.right")
    
    init(image: String, label: String, description: String) {
        
        self.infoImage = image
        self.infoLabel = label
        self.infoDescription = description
        
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView {
    private func setupViews() {
        self.addSubview(aboutStudioContainer)
        self.addSubview(aboutButton)
        
        aboutStudioContainer.addArrangedSubview(aboutStudioImageView)
        aboutStudioContainer.addArrangedSubview(aboutDescriptionContainer)
        
        aboutDescriptionContainer.addArrangedSubview(aboutStudioLabel)
        aboutDescriptionContainer.addArrangedSubview(aboutStudioDespriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aboutStudioContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            aboutStudioContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            aboutStudioContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            aboutStudioContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            aboutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            aboutButton.trailingAnchor.constraint(equalTo: aboutStudioContainer.trailingAnchor, constant: -10),
        ])
    }
}
