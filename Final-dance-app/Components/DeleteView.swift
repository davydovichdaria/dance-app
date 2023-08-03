import UIKit

final class DeleteView: UIControl {
    
    var index: Int = 0
    
    private lazy var deleteComponentView: UIStackView = {
        var stackView = UIStackView()
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.alignment = .center
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 30).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var deleteButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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

    var currentValue: Int = 0 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
        }
    }
    
    //MARK: - Actions with buttons
    @objc func buttonAction(_ sender: UIButton) {
        switch sender {
        case deleteButton:
            currentValue -= 1
        default: break
        }
        
        sendActions(for: .valueChanged)
    }
}

//MARK: - Constraints
extension DeleteView {
    private func setupViews() {
        
        self.addSubview(deleteComponentView)
        
        deleteComponentView.addArrangedSubview(deleteButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            deleteComponentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            deleteComponentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            deleteComponentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            deleteComponentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
}
