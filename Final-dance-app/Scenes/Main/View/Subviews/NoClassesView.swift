import UIKit

final class NoClassesView: UIView {
    
    var onScheduleButtonAction: (()->())?
    
    private let classesContainerStackView = ContainerVerticalStackView()
    
    private let noClassesTitileLabel = Label(style: .title, text: "There are no classes")
    
    private let noClassesDescriptionLabel = Label(style: .description, text: "You are not signed up for training")
    
    private let goScheduleButton: UIButton = {
        let button = Button(style: .purpleButton, text: "Go to the schedule")
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
        onScheduleButtonAction?()
    }
}

//MARK: -Layout configuration
extension NoClassesView {
    
    private func setupViews() {
        self.addSubview(classesContainerStackView)
        
        classesContainerStackView.addArrangedSubview(noClassesTitileLabel)
        classesContainerStackView.addArrangedSubview(noClassesDescriptionLabel)
        classesContainerStackView.addArrangedSubview(goScheduleButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            classesContainerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            classesContainerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            classesContainerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            classesContainerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
