import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var parameters: [URLQueryItem]? { get }
    var method: HTTPMethods { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "apingweb.com"
    }
    
    var header: [String: String]? {
        return ["content-type":"application/json; charset=utf-8"]
    }
}
