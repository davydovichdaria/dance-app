import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    private var scheduleView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    var scheduleAPI = ScheduleAPIImpl.init()
    
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
        
        scheduleAPI.fetchSchedule(endpoint: endpoint) { result in
            switch result {
            case .success(let schedule):
                self.scheduleView.scheduleTableView.update(schedule)
                self.scheduleView.scheduleTableView.reloadData()
            case .failure(_):
                print("Some error")
            }
        }
    }

    override func loadView() {
        self.view = ScheduleScreenView.init(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"

        scheduleView.calendarState.subscribe(client: self)
        
        todayDayIndex = returnWeekDay()
        fetchDailySchedule(day: todayDayIndex)
        
        // Navigation
        scheduleView.scheduleTableView.onClassesCellSelected = { classes in
            self.showDetailClasses(classes, self.scheduleView.calendarState)
        }
    }
    
    func showDetailClasses(_ classes: Schedule, _ date: DayViewState) {
        let controller = DetailScreenVC(classes: classes, selectedDay: date)
        self.navigationController?.pushViewController(controller, animated: true)
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
