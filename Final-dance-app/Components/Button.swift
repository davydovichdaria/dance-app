import UIKit

enum ButtonStyle: Int {
    case chevron
}

class Button: UIButton {
    init(style: ButtonStyle, text: String) {
        super.init(frame: .zero)
        
        switch style {
        case .chevron: createChevronButton(text: text)
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
}
