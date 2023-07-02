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
            return "/api/rest/7493d4ddb82ce9f72f47ad08c492575119/tuesday"
        case .getWednesday:
            return "/api/rest/879ac331f524025429ee1278979a122717/wednesday"
        case .getThursday:
            return "/api/rest/9f46c91cbc845774f22d35804c895b2924/thursday"
        case .getFriday:
            return "/api/rest/11f0884feb5a716b0381e9901d48be1e21/friday"
        case .getSaturday:
            return "/api/rest/50af57dc0f0adbdc1705c766f22db9326/saturday"
        case .getSunday:
            return "/api/rest/4be8df57bb37724af81ef1f42fec5dcd18/sunday"
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
