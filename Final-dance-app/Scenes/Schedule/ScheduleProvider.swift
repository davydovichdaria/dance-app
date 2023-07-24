import Foundation

protocol ScheduleProvider {
    var dayService: DayService { get set }
    var scheduleApi: ScheduleApiClient { get set }
}

class ScheduleProviderImpl: ScheduleProvider {
    var dayService: DayService
    var scheduleApi: ScheduleApiClient
    
    init(dayService: DayService, scheduleApi: ScheduleApiClient) {
        self.dayService = dayService
        self.scheduleApi = scheduleApi
    }
}
