import UIKit
import CalendarKit

class DetailScreenVC: UIViewController {
    
    private var detailView: DetailScreenView {
        return self.view as! DetailScreenView
    }
    
    var currentClass: Schedule
    
    var tappedDay: DayViewState
    
    var classesArchiver = ClassesRepositoryImpl()
    
    var profileVC = ProfileScreenVC()
    
    init(classes: Schedule, selectedDay: DayViewState) {
        self.currentClass = classes
        self.tappedDay = selectedDay
        
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
        
        detailView.onSignUpButtonTapped = {
            self.signUpToWorkout()
        }
        
        detailView.update(currentClass: currentClass, day: tappedDay)
    }
    
    func signUpToWorkout() {
        var futureClasses = classesArchiver.retrive() //Получили массив из хранилища
        
        let selectedLesson = DailyClasses(lesson: currentClass, day: fetchSelectedDay())
        
        let isRepeatedClasses = futureClasses.contains { $0.day == selectedLesson.day && $0.lesson.time == selectedLesson.lesson.time}
        
        defer {
            classesArchiver.save(futureClasses)
            profileVC.profileView.classesTableView.reloadData()
            print(futureClasses.count)
        }
        
        if futureClasses.isEmpty || !isRepeatedClasses {
            futureClasses.append(selectedLesson)
            selectedLesson.count = 1
            return //Возвращаемся к defer и выходим из функции
        }
    }
    
    func fetchSelectedDay() -> String {
        let calendar = Calendar.autoupdatingCurrent
        
        let date = tappedDay.selectedDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
}
