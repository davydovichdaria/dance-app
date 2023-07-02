import UIKit
import CalendarKit

enum Days: Int {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

class ScheduleScreenView: UIView {
    
    var schedule: [Int: [Schedule]] = [:]
    
    var mondaySchedule: [Schedule] = []
    var tuesdaySchedule: [Schedule] = []
    var wednesdaySchedule: [Schedule] = []
    var thursdaySchedule: [Schedule] = []
    var fridaySchedule: [Schedule] = []
    var saturdaySchedule: [Schedule] = []
    var sundaySchedule: [Schedule] = []
    
    
    var calendarView: DayHeaderView = {
        var calendarView = DayHeaderView(calendar: Calendar.autoupdatingCurrent)
        
        var style = DayHeaderStyle()
        
        style.daySelector.inactiveBackgroundColor = .white
        style.daySelector.inactiveTextColor = .black
        style.daySelector.todayActiveBackgroundColor = UIColor(named: "dark purple") ?? .systemPink
        style.daySelector.todayActiveTextColor = .white
        style.daySelector.selectedBackgroundColor = .systemPink.withAlphaComponent(0.5)
        style.daySelector.activeTextColor = .white
        
        calendarView.updateStyle(style)
        return calendarView
    }()
    
    var scheduleTableView = ScheduleTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSchedule(_ schedule: [Schedule]) {
        self.mondaySchedule = schedule
        scheduleTableView.update(schedule)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(calendarView)
        self.addSubview(scheduleTableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            scheduleTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scheduleTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scheduleTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
