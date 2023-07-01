import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    var mondayScheduleAPI = MondayScheduleImpl.init()
    var mondaySchedule: [Schedule] = []
    
    private var scheduleScreenView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    override func loadView() {
        self.view = ScheduleScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
        fetchSchedule()
        
    }
    
    func fetchSchedule() {
        Task {
            do {
                let scheduleResponse = try await mondayScheduleAPI.fetchSchedule()
                mondaySchedule = scheduleResponse.monday
                print(mondaySchedule.count)
                scheduleScreenView.updateSchedule(mondaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }


    
}


