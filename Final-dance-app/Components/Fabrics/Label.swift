import UIKit

enum LabelStyle: Int {
    case typesOfClasses
    case title
    case description
    case descriptionSmall
    case time
    case trainerName
}

class Label: UILabel {
    init(style: LabelStyle, text: String) {
        super.init(frame: .zero)
        
        switch style {
        case .typesOfClasses: createTypesOfClassesLabel(text: text)
        case .title: createTitleLabel(text: text)
        case .description: createDespriptionLabel(text: text)
        case .descriptionSmall: createDespriptionSmallLabel(text: text)
        case .time: createTimeLabel(text: text)
        case .trainerName: createTrainerNameLabel(text: text)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTypesOfClassesLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createTitleLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func createDespriptionLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.textColor = .lightGray
        self.numberOfLines = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createDespriptionSmallLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.textColor = .lightGray
        self.numberOfLines = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createTimeLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .light)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createTrainerNameLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.textColor = .black.withAlphaComponent(0.8)
        self.numberOfLines = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
