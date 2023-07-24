import Foundation

protocol DayService {
    
    func initialLoading() -> ScheduleEndpoint
    func fetchDailySchedule(day: Int) -> ScheduleEndpoint
}

class DayServiceImpl: DayService {

    func initialLoading() -> ScheduleEndpoint {
        let todayDayIndex = returnWeekDay()
        return self.fetchDailySchedule(day: todayDayIndex)
    }

    func fetchDailySchedule(day: Int) -> ScheduleEndpoint {
            let weekDay = Days.init(rawValue: day)
            
            switch weekDay  {
            case .sunday: return ScheduleEndpoint.getSunday
            case .monday: return ScheduleEndpoint.getMonday
            case .tuesday: return ScheduleEndpoint.getTuesday
            case .wednesday: return ScheduleEndpoint.getWednesday
            case .thursday: return ScheduleEndpoint.getThursday
            case .friday: return ScheduleEndpoint.getFriday
            case .saturday: return ScheduleEndpoint.getSaturday
            default: return ScheduleEndpoint.getSunday
            }
        }
    
//MARK: - Private logic
    func returnWeekDay() -> Int {
        let calendar = Calendar.autoupdatingCurrent
        let dateNow = Date()
        let dayOfWeek = calendar.component(.weekday, from: dateNow)
        return dayOfWeek
    }
}
