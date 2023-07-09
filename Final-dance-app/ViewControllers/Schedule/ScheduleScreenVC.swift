import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    var dayNow: Int = 0
    
    var scheduleAPI = ScheduleAPIImpl.init()
    var schedule: [Schedule] = []
    
    private var scheduleScreenView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    override func loadView() {
        self.view = ScheduleScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
        returnWeekDay()
        
        fetchDailySchedule(day: dayNow)
        
        scheduleScreenView.onDateLabelSelected = { day in
            self.fetchDailySchedule(day: day)
        }
        
        
        scheduleScreenView.scheduleTableView.onClassesCellSelected = { classes in
            self.showDetailClasses(classes)
        }
    }
    
    func showDetailClasses(_ lesson: Schedule) {
        let controller = DetailScreenVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func returnWeekDay() {
        let calendar = Calendar.autoupdatingCurrent
        let dateNow = Date()
        let dayOfWeek = calendar.component(.weekday, from: dateNow)
        self.dayNow = dayOfWeek
        print(dayOfWeek)
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
                    self.schedule = scheduleResponse.schedule
                print(schedule.count)
                scheduleScreenView.updateSchedule(schedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}
