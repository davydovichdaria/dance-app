import UIKit
import CalendarKit

final class InfoClassesView: UIView {
    
    private var infoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.widthAnchor.constraint(equalToConstant: Screen.width).isActive = true
        stackView.backgroundColor = .white.withAlphaComponent(0.9)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var infoClassesStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var infoTimeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 15, trailing: 15)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let typeTitleLabel: UILabel = {
        var label = Label(style: .descriptionSmall, text: "GROUP LESSON")
        label.textColor = UIColor(named: "dark purple")
        return label
    }()
    private var typeOfClassLabel = Label(style: .typesOfClasses, text: "Twerk (beginner)")
    private var dateOfClassLabel = Label(style: .time, text: "default day")
    private let registrationLabel = Label(style: .description, text: "Pre-registration")
    private let separatorView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let placeTitleLabel = Label(style: .title, text: "Place")
    private var placeLabel = Label(style: .description, text: "White")
    
    private var timeLabel = Label(style: .typesOfClasses, text: "18:00")
    private let durationLabel = Label(style: .description, text: "60 min")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ lesson: Schedule, day: DayViewState) {
        let calendar = Calendar.autoupdatingCurrent
        let date = day.selectedDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        let weekDay = dateFormatter.string(from: date)
        
        
        dateOfClassLabel.text = "\(weekDay)"
        typeOfClassLabel.text = lesson.name
        placeLabel.text = lesson.room
        timeLabel.text = lesson.time
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(infoClassesStackView)
        infoStackView.addArrangedSubview(infoTimeStackView)
        
        infoClassesStackView.addArrangedSubview(typeTitleLabel)
        infoClassesStackView.addArrangedSubview(typeOfClassLabel)
        infoClassesStackView.addArrangedSubview(dateOfClassLabel)
        infoClassesStackView.addArrangedSubview(registrationLabel)
        infoClassesStackView.addArrangedSubview(separatorView)
        infoClassesStackView.addArrangedSubview(placeTitleLabel)
        infoClassesStackView.addArrangedSubview(placeLabel)
        
        infoTimeStackView.addArrangedSubview(timeLabel)
        infoTimeStackView.addArrangedSubview(durationLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
}
