import UIKit
import CalendarKit

class DetailScreenVC: UIViewController {
    
    private var currentClass: Schedule
    
    private var tappedDay: DayViewState
    
    var detailProvider: DetailProvider
    
    private var detailView: DetailScreenView {
        return self.view as! DetailScreenView
    }
    
    init(classes: Schedule,
         selectedDay: DayViewState,
         detailProvider: DetailProvider) {
        self.currentClass = classes
        self.tappedDay = selectedDay
        self.detailProvider = detailProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = DetailScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.onSignUpButtonTapped = { [self] in
            detailProvider.signUpToWorkout(lesson: currentClass, selectedDay: tappedDay)
            self.navigationController?.popViewController(animated: true)
        }
        detailView.update(currentClass: currentClass, day: tappedDay)
    }
}
