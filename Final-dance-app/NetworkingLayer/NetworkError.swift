import Foundation

enum NetworkError: Error {
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown
    case invalidRequest
    case decode
    case unauthorized
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL error"
        case .noResponse:
            return "No response error"
        case .unexpectedStatusCode:
            return "Unexpected status code error"
        case .unknown:
           return "Unknown error"
        case .invalidRequest:
            return "Invalid request error"
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Unauthorized error"
        }
    }
}
