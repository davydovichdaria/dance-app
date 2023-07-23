import UIKit
import CalendarKit

class ScheduleScreenView: UIView {
    
     lazy var calendarState: DayViewState = {
        let state = DayViewState(date: Date(), calendar: Calendar.autoupdatingCurrent)
        return state
    }()
    
    lazy var calendarView: DayHeaderView = {
        let calendar = Calendar.autoupdatingCurrent
        var calendarView = DayHeaderView(calendar: calendar)
        calendarView.state = calendarState
        
        var style = DayHeaderStyle()
        style.daySelector.inactiveBackgroundColor = .white
        style.daySelector.inactiveTextColor = .black
        style.daySelector.todayActiveBackgroundColor = UIColor(named: "dark purple") ?? .systemPink
        style.daySelector.todayActiveTextColor = .white
        style.daySelector.selectedBackgroundColor = UIColor(named: "dark purple") ?? .systemPink
        style.daySelector.activeTextColor = .white
        style.daySelector.todayInactiveTextColor = .black
        
        calendarView.updateStyle(style)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarView
    }()
    
    var scheduleTableView = ScheduleTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layout configuration
extension ScheduleScreenView {
    
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
            calendarView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            scheduleTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scheduleTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scheduleTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

