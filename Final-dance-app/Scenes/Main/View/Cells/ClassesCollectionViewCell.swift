import UIKit

final class ClassesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ClassesTableViewCell"
    
    private var scheduleContainerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 20
        
        stackView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowColor = UIColor.gray.cgColor
        stackView.layer.shadowRadius = 11.0
        stackView.layer.masksToBounds = false
        
        
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
    private var dayLabel = Label(style: .description, text: "default day")
    private var teacherLabel = Label(style: .descriptionSmall, text: "Veronica")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        bulletStackView.addArrangedSubview(markView)
        
        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(durationLabel)
        
        infoClassesStackView.addArrangedSubview(nameLabel)
        infoClassesStackView.addArrangedSubview(typeLabel)
        infoClassesStackView.addArrangedSubview(dayLabel)
        infoClassesStackView.addArrangedSubview(teacherLabel)
        
  
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scheduleContainerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            scheduleContainerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            scheduleContainerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            scheduleContainerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            markView.leadingAnchor.constraint(equalTo: bulletStackView.leadingAnchor, constant: 10),
            markView.topAnchor.constraint(equalTo: bulletStackView.topAnchor, constant: 15),
        ])

    }
    
    //MARK: - Public
    func update(_ schedule: DailyClasses) {
        timeLabel.text = schedule.lesson.time
        nameLabel.text = schedule.lesson.name
        typeLabel.text = schedule.lesson.type
        dayLabel.text = schedule.day
        teacherLabel.text = schedule.lesson.teacher
        markView.backgroundColor = UIColor(named: schedule.lesson.mark)
    }
}

