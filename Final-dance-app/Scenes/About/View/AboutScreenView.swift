import UIKit

class AboutScreenView: UIView {
    
    var aboutTableView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel = Label(style: .title, text: "Our address")
    let addressLabel = Label(style: .time, text: "Minsk, Kuibysheva, 22")
    
    let workingHoursTitileLabel = Label(style: .title, text: "Working hours")
    let hoursLabel = Label(style: .time, text: "From 9:00 to 24:00")
    
    let mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map")
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: Screen.width * 0.9).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.6).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AboutScreenView {
    
    func setupViews() {
        self.addSubview(aboutTableView)
        

        aboutTableView.addArrangedSubview(workingHoursTitileLabel)
        aboutTableView.addArrangedSubview(hoursLabel)
        aboutTableView.addArrangedSubview(titleLabel)
        aboutTableView.addArrangedSubview(addressLabel)
        aboutTableView.addArrangedSubview(mapImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            aboutTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            aboutTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            aboutTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mapImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Screen.width * 0.05),
            mapImageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 40)
        ])
    }
}
