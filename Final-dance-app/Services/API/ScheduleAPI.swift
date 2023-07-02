import UIKit

protocol ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse
}

class MondayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getMonday, responseModel: ScheduleResponse.self)
    }
}

class TuesdayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getTuesday, responseModel: ScheduleResponse.self)
    }
}

class WednesdayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getWednesday, responseModel: ScheduleResponse.self)
    }
}

class ThursdayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getThursday, responseModel: ScheduleResponse.self)
    }
}

class FridayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getFriday, responseModel: ScheduleResponse.self)
    }
}

class SaturdayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getSaturday, responseModel: ScheduleResponse.self)
    }
}

class SundayScheduleImpl: API, ScheduleAPI {
    func fetchSchedule() async throws -> ScheduleResponse {
        return try await request(endpoint: ScheduleEndpoint.getSunday, responseModel: ScheduleResponse.self)
    }
}
