import Foundation
import CalendarKit

protocol DetailProvider {
    
    var repository: ClassesRepository { get set }
    
    func signUpToWorkout(lesson: Schedule, selectedDay: DayViewState)
}

class DetailProviderImpl: DetailProvider {

    var repository: ClassesRepository
    
    init(repository: ClassesRepository) {
        self.repository = repository
    }
    
    func signUpToWorkout(lesson: Schedule, selectedDay: DayViewState) {
        var futureClasses = repository.retrive()
        
        let selectedLesson = DailyClasses(lesson: lesson, day: fetchSelectedDay(selectedDay: selectedDay))
        
        let isRepeatedClasses = futureClasses.contains { $0.day == selectedLesson.day && $0.lesson.time == selectedLesson.lesson.time}
        
        defer {
            repository.save(futureClasses)
        }
        
        if futureClasses.isEmpty || !isRepeatedClasses {
            futureClasses.append(selectedLesson)
            selectedLesson.count = 1
            return //Возвращаемся к defer и выходим из функции
        }
    }
    
    func fetchSelectedDay(selectedDay: DayViewState) -> String {
        
        let date = selectedDay.selectedDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
}
