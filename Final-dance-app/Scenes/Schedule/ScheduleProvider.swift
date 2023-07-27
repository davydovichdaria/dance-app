import Foundation

protocol ScheduleProvider {
    var onClassesLoaded: (([Schedule])->())? { get set }
    
    func fetchClasses(_ endpoint: ScheduleEndpoint)
    func fetchEndpoint() -> ScheduleEndpoint
    func fetchEndpoint(_ day: Int) -> ScheduleEndpoint
}

class ScheduleProviderImpl: ScheduleProvider {
    
    var onClassesLoaded: (([Schedule])->())?
    
    var dayService: DayService
    var scheduleApi: ScheduleApiClient
    
    init(dayService: DayService, scheduleApi: ScheduleApiClient) {
        self.dayService = dayService
        self.scheduleApi = scheduleApi
    }
    
    func fetchClasses(_ endpoint: ScheduleEndpoint) {
        scheduleApi.fetchSchedule(endpoint: endpoint) { result in
            switch result {
            case .success(let schedule):
                self.onClassesLoaded?(schedule)
            case .failure(_):
                print("No data")
            }
        }
    }
    
    func fetchEndpoint() -> ScheduleEndpoint {
        return dayService.initialLoading()
    }
    
    func fetchEndpoint(_ day: Int) -> ScheduleEndpoint {
        return dayService.fetchDailySchedule(day: day)
    }
}
