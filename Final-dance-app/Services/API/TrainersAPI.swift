import UIKit

protocol TrainersAPI {
    func fetchTrainers() async throws -> TrainersResponse
}

class TrainersAPIImpl: API, TrainersAPI {
    func fetchTrainers() async throws -> TrainersResponse {
        return try await request(endpoint: TrainersEndpoint.getTrainers, responseModel: TrainersResponse.self)
    }
}
