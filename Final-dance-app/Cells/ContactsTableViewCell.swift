import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var onScheduleButtonTapped: (()->())?
    
    static let reuseID = "ContactsTableViewCell"
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 20, trailing: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let contactsLabel = Label(style: .typesOfClasses, text: "Sign up for a workout")
    
    let phoneTitleLabel = Label(style: .title, text: "Phone number:")
    
    var phoneNumberLabel = Label(style: .trainerName, text: "+375 (33) 537-76-45")
    
    let scheduleTitleLabel = Label(style: .title, text: "In our mobile app:")
    
    let goToScheduleButton: UIButton = {
        let button = Button(style: .purpleBackgroundButton, text: "Go to schedule")
        button.addTarget(self, action: #selector(didScheduleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didScheduleButtonTapped() {
        onScheduleButtonTapped?()
    }
}

//MARK: - Layout configuration
extension ContactsTableViewCell {
    func setupViews() {
        contentView.addSubview(containerStackView)
        contentView.backgroundColor = Colors.background
        
        containerStackView.addArrangedSubview(contactsLabel)
        containerStackView.addArrangedSubview(phoneTitleLabel)
        containerStackView.addArrangedSubview(phoneNumberLabel)
        containerStackView.addArrangedSubview(scheduleTitleLabel)
        containerStackView.addArrangedSubview(goToScheduleButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            phoneTitleLabel.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 20),
        ])
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            scheduleTitleLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
        ])
        
    }
}
