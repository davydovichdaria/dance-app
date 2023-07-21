import UIKit
import CalendarKit
import Combine

class ScheduleScreenVC: UIViewController {
    
    private var scheduleAPI = ScheduleAPIImpl.init()
    
    var todayDayIndex: Int!
    
    
    
    func returnWeekDay() -> Int {
        let calendar = Calendar.autoupdatingCurrent
        let dateNow = Date()
        let dayOfWeek = calendar.component(.weekday, from: dateNow)
        return dayOfWeek
    }
    func fetchDailySchedule(day: Int) {
        let weekDay = Days.init(rawValue: day)
        
        switch weekDay  {
        case .sunday: fetchDaySchedule(endpoint: ScheduleEndpoint.getSunday)
        case .monday: fetchDaySchedule(endpoint: ScheduleEndpoint.getMonday)
        case .tuesday: fetchDaySchedule(endpoint: ScheduleEndpoint.getTuesday)
        case .wednesday: fetchDaySchedule(endpoint: ScheduleEndpoint.getWednesday)
        case .thursday: fetchDaySchedule(endpoint: ScheduleEndpoint.getThursday)
        case .friday: fetchDaySchedule(endpoint: ScheduleEndpoint.getFriday)
        case .saturday: fetchDaySchedule(endpoint: ScheduleEndpoint.getSaturday)
        default: print("No data")
        }
    }
    
    func fetchDaySchedule(endpoint: Endpoint) {
        Task {
            do {
                let scheduleResponse = try await scheduleAPI.fetchSchedule(endpoint: endpoint)
                let schedule = scheduleResponse.schedule
                scheduleTableView.update(schedule)
                scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private lazy var calendarState: DayViewState = {
        let state = DayViewState(date: Date(), calendar: Calendar.autoupdatingCurrent)
        state.subscribe(client: self)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
        setupViews()
        setupConstraints()
        
        todayDayIndex = returnWeekDay()
        fetchDailySchedule(day: todayDayIndex)
        
        
        
        // Navigation
        scheduleTableView.onClassesCellSelected = { classes in
            self.showDetailClasses(classes, self.calendarState)
        }
    }
    
    func showDetailClasses(_ classes: Schedule, _ date: DayViewState) {
        let controller = DetailScreenVC(classes: classes, selectedDay: date)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
    //MARK: - Layout configuration
    
    extension ScheduleScreenVC {
        
        private func setupViews() {
            view.backgroundColor = .white
            view.addSubview(calendarView)
            view.addSubview(scheduleTableView)
        }
        
        private func setupConstraints() {
            
            NSLayoutConstraint.activate([
                calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                calendarView.heightAnchor.constraint(equalToConstant: 90)
            ])
            
            NSLayoutConstraint.activate([
                scheduleTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
                scheduleTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                scheduleTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
        }
    }


//MARK: - DayViewStateUpdating

extension ScheduleScreenVC: DayViewStateUpdating {
    
    func move(from oldDate: Date, to newDate: Date) {
        print("$0: \(newDate)")
        let calendar = Calendar.autoupdatingCurrent
        let dayOfWeek = calendar.component(.weekday, from: newDate)
        
        fetchDailySchedule(day: dayOfWeek)
        
    }
}
