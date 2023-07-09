import UIKit

enum MarkColors: String {
case pink = ".systemPink"
}

final class ScheduleTableViewCell: UITableViewCell {
    
    static let reuseId = "ScheduleTableViewCell"
    
    private var scheduleContainerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var bulletStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.widthAnchor.constraint(equalToConstant: Screen.width * 0.05).isActive = true
        return stackView
    }()
    
    private var markView: UIView = {
        var view = UIView.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.layer.cornerRadius = 5
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
    private var timeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)
        stackView.widthAnchor.constraint(equalToConstant: Screen.width * 0.15).isActive = true
        return stackView
    }()
    
    private var timeLabel = Label(style: .time, text: "11:00")
    private var durationLabel = Label(style: .descriptionSmall, text: "60 min")
    
    private var infoClassesStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 0)
        stackView.widthAnchor.constraint(equalToConstant: Screen.width * 0.7).isActive = true
        return stackView
    }()
    
    private var nameLabel = Label(style: .title, text: "Girly choreo (beginner)")
    private var typeLabel = Label(style: .descriptionSmall, text: "Group lesson")
    private var teacherLabel = Label(style: .descriptionSmall, text: "Veronica")
    private var roomLabel = Label(style: .descriptionSmall, text: "White")
    
    private var chevronStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins.trailing = 10
        stackView.widthAnchor.constraint(equalToConstant: Screen.width * 0.1).isActive = true
        return stackView
    }()
    
    private var chevronButton = Button(style: .chevron, text: "chevron.right")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(scheduleContainerStackView)
        
        scheduleContainerStackView.addArrangedSubview(bulletStackView)
        scheduleContainerStackView.addArrangedSubview(timeStackView)
        scheduleContainerStackView.addArrangedSubview(infoClassesStackView)
        scheduleContainerStackView.addArrangedSubview(chevronStackView)
        
        bulletStackView.addArrangedSubview(markView)
        
        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(durationLabel)
        
        infoClassesStackView.addArrangedSubview(nameLabel)
        infoClassesStackView.addArrangedSubview(typeLabel)
        infoClassesStackView.addArrangedSubview(teacherLabel)
        infoClassesStackView.addArrangedSubview(roomLabel)
        
        chevronStackView.addArrangedSubview(chevronButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scheduleContainerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            scheduleContainerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            scheduleContainerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            scheduleContainerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            markView.leadingAnchor.constraint(equalTo: bulletStackView.leadingAnchor, constant: 10),
            markView.topAnchor.constraint(equalTo: bulletStackView.topAnchor, constant: 15),
        ])

        
        NSLayoutConstraint.activate([
            chevronButton.topAnchor.constraint(equalTo: chevronStackView.topAnchor, constant: 35)
        ])
    }
    
    //MARK: - Public
    func update(_ schedule: Schedule) {
        timeLabel.text = schedule.time
        nameLabel.text = schedule.name
        typeLabel.text = schedule.type
        teacherLabel.text = schedule.teacher
        roomLabel.text = schedule.room
        markView.backgroundColor = UIColor(named: schedule.mark)
    }
    
}
