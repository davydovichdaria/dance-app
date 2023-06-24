import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    private var scheduleScreenView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    override func loadView() {
        self.view = ScheduleScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
    }


    
}


