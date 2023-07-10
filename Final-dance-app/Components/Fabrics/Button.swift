import UIKit

enum ButtonStyle: Int {
    case chevron
    case purpleButton
    case purpleBackgroundButton
}

class Button: UIButton {
    init(style: ButtonStyle, text: String) {
        super.init(frame: .zero)
        
        switch style {
        case .chevron: createChevronButton(text: text)
        case .purpleButton: createPurpleButton(text: text)
        case .purpleBackgroundButton: createPurpleBackgroundButton(text: text)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createChevronButton(text: String) {
        self.setImage(UIImage(systemName: text), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor.blue.withAlphaComponent(0.6)
    }
    
    func createPurpleButton(text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor(named: "dark purple"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createPurpleBackgroundButton(text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(named: "dark purple")?.withAlphaComponent(0.8)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 14
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
