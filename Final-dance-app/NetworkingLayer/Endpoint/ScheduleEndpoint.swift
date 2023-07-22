import Foundation

enum ScheduleEndpoint {
    case getMonday
    case getTuesday
    case getWednesday
    case getThursday
    case getFriday
    case getSaturday
    case getSunday
}

extension ScheduleEndpoint: Endpoint {
    
    var method: HTTPMethods {
        switch self {
        case .getMonday:
            return .get
        case .getTuesday:
            return .get
        case .getWednesday:
            return .get
        case .getThursday:
            return .get
        case .getFriday:
            return .get
        case .getSaturday:
            return .get
        case .getSunday:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getMonday:
            return "/api/rest/1d63a4c4bc250fbb254d9aa1f6560c1619/monday"
        case .getTuesday:
            return "/api/rest/b2c2b66a8d8c402b6124b4c091cafa291/tuesday"
        case .getWednesday:
            return "/api/rest/ee6e6ae8f0423f831c4b8cf346791c9125/wednesday"
        case .getThursday:
            return "/api/rest/1eb5af7ed0dbcf7c9dd4a3bbf60c86d93/thursday"
        case .getFriday:
            return "/api/rest/9668a6dbe8b7bf13b0cc2cce72b4d6405/friday"
        case .getSaturday:
            return "/api/rest/dbfb95d934b68dd2037316d40a1a69264/saturday"
        case .getSunday:
            return "/api/rest/55bf2ffd2a522d28472c3883cf5f90b41/sunday"
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
