import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    var scheduleProvider: ScheduleProvider
    
    private var scheduleView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    init(scheduleProvider: ScheduleProvider) {
        self.scheduleProvider = scheduleProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ScheduleScreenView.init(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"

        scheduleView.calendarState.subscribe(client: self)
    
        let endpoint = scheduleProvider.dayService.initialLoading()
        fetchDaySchedule(endpoint: endpoint)

        // Navigation
        scheduleView.scheduleTableView.onClassesCellSelected = { classes in
            self.showDetailClasses(classes, self.scheduleView.calendarState)
        }
    }
    
    func fetchDaySchedule(endpoint: Endpoint) {
        
        scheduleProvider.scheduleApi.fetchSchedule(endpoint: endpoint) { result in
            switch result {
            case .success(let schedule):
                self.scheduleView.scheduleTableView.update(schedule)
                self.scheduleView.scheduleTableView.reloadData()
            case .failure(_):
                print("Some error")
            }
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
        
        let endpoint = scheduleProvider.dayService.fetchDailySchedule(day: dayOfWeek)
        self.fetchDaySchedule(endpoint: endpoint)
    }
}
