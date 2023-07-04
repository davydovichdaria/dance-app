import UIKit

final class ClassesView: UIView {
    
    var onScheduleButtonAction: (()->())? //объявили
    
    private let classesContainerStackView = ContainerVerticalStackView()
    private let noClassesTitileLabel = Label(style: .title, text: "There are no classes")
    
    private let noClassesDescriptionLabel = Label(style: .description, text: "You are not signed up for training")
    
    private let goScheduleButton: UIButton = {
        var button = UIButton()
        button.setTitle("Go to the schedule", for: .normal)
        button.setTitleColor(.blue.withAlphaComponent(0.6), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func scheduleButtonTapped() {
        onScheduleButtonAction?() //приняли
    }
}

extension ClassesView {
    private func setupViews() {
        self.addSubview(classesContainerStackView)
        
        classesContainerStackView.addArrangedSubview(noClassesTitileLabel)
        classesContainerStackView.addArrangedSubview(noClassesDescriptionLabel)
        classesContainerStackView.addArrangedSubview(goScheduleButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            classesContainerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            classesContainerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            classesContainerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            classesContainerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
