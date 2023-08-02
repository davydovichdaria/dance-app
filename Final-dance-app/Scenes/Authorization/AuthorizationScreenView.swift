import UIKit

class AuthorizationScreenView: UIView {
    
    var status = ""

    var onEnterButtonTapped: (()->())?
    var onRegisterButtonTapped: (()->())?
    
//    var containerView: UIStackView = {
//        var stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .equalCentering
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    var loginDetailsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var titleLabel = Label(style: .title, text: "Enter your login and password")
    var descriptionLabel = Label(style: .description, text: "To log in to your profile")
    
    var loginTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Login"
        textField.clearButtonMode = .always
        textField.textAlignment = .left
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.clearButtonMode = .always
        textField.textAlignment = .left
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var registerButton: UIButton = {
        var button = Button(style: .purpleBackgroundButton, text: "Register")
        button.addTarget(self, action: #selector(registerScreen), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var enterButton: UIButton = {
        var button = Button(style: .purpleBackgroundButton, text: "Sign in")
        button.addTarget(self, action: #selector(createScreen), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var errorLabel: UILabel = {
        let label = Label(style: .trainerName, text: "Incorrect login or password")
        label.textColor = .systemRed
        return label
    }()
    
    @objc func registerScreen() {
        onRegisterButtonTapped?()
    }
    
    @objc func createScreen() {
        onEnterButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        errorLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = Colors.background
        
        self.addSubview(loginDetailsStackView)
        
        loginDetailsStackView.addArrangedSubview(titleLabel)
        loginDetailsStackView.addArrangedSubview(descriptionLabel)
        loginDetailsStackView.addArrangedSubview(loginTextField)
        loginDetailsStackView.addArrangedSubview(passwordTextField)
        
        self.addSubview(errorLabel)
        self.addSubview(enterButton)
        self.addSubview(registerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginDetailsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(Screen.width * 0.2)),
            loginDetailsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: loginDetailsStackView.bottomAnchor, constant: 20),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
