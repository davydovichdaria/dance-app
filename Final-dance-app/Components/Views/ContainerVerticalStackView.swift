import UIKit

class ContainerVerticalStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .vertical
        self.spacing = 5
        self.alignment = .center
        self.distribution = .equalSpacing
        self.backgroundColor = .white

        self.layer.cornerRadius = 15
        self.contentMode = .center

        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10)
        self.isLayoutMarginsRelativeArrangement = true

        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 11.0
        self.layer.masksToBounds = false

        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

