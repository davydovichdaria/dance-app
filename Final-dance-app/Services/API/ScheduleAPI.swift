import UIKit

protocol ScheduleApiClient {
    func fetchSchedule(endpoint: Endpoint, completion: @escaping((Result<[Schedule], Error>)->()))
}

class ScheduleApiClientImpl: ScheduleApiClient {
    
    func fetchSchedule(endpoint: Endpoint, completion: @escaping ((Result<[Schedule], Error>) -> ())) {
        
        let session = URLSession.init(configuration: .default)
        
        var urlComponents = URLComponents.init()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url
                
        else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        print(url)
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.noResponse))
                print(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    print("Success Status: \(response.statusCode)")
                    break
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let scheduleResponse = try decoder.decode(ScheduleResponse.self, from: data)
                let schedule = scheduleResponse.schedule
                DispatchQueue.main.async {
                    completion(.success(schedule))
                }
            } catch {
                print(NetworkError.decode)
            }
            
        }.resume()
    }
}
