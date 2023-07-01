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
            return "/api/rest/363a6410bba40afba865566208447d1012/monday"
        case .getTuesday:
            return "/api/rest/a14241a4d6bb24621d3c3c6f93ea6ec314/tuesday"
        case .getWednesday:
            return "/api/rest/f419e28adc3fcf18fb4a7265965c5f4512/wednesday"
        case .getThursday:
            return "/api/rest/e1c2508f14289c99414363bb9a3731773/thursday"
        case .getFriday:
            return "/api/rest/2bb5470e6c163afb61f9e6d0a8907a3e23/friday"
        case .getSaturday:
            return "/api/rest/ab5025e99d17c4bce96893218c21c7b512/saturday"
        case .getSunday:
            return "/api/rest/9e66ddfc9df399f3f83ce26465c2c0362/sunday"
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
