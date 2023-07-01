import UIKit

protocol ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse
}

class MondayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getMonday, responseModel: ScheduleResponse.self)
    }
}
