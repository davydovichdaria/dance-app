import UIKit

protocol ScheduleAPI {
    func fetchSchedule(endpoint: Endpoint) async throws -> ScheduleResponse
}

class ScheduleAPIImpl: API, ScheduleAPI {
    func fetchSchedule(endpoint: Endpoint) async throws -> ScheduleResponse {
        return try await request(endpoint: endpoint, responseModel: ScheduleResponse.self)
    }
}
