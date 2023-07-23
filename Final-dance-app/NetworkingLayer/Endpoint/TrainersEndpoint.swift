import Foundation

enum TrainersEndpoint {
    case getTrainers
}

extension TrainersEndpoint: Endpoint {
    
    var method: HTTPMethods {
        switch self {
        case .getTrainers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTrainers:
            return "/api/rest/12212fd761880fe050226522049eecf00/trainers"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default: return []
        }
    }
    
    var body: [String : String]? {
        switch self {
        default: return nil
        }
    }
}

