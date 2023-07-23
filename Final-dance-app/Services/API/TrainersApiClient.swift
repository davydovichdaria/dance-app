import UIKit

protocol TrainersApiClient {
    func fetchSchedule(endpoint: Endpoint, completion: @escaping((Result<[Trainer], Error>)->()))
}

class TrainersApiClientImpl: TrainersApiClient {
    
    func fetchSchedule(endpoint: Endpoint, completion: @escaping ((Result<[Trainer], Error>) -> ())) {
        
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
                let trainersResponse = try decoder.decode(TrainersResponse.self, from: data)
                let trainers = trainersResponse.trainers
                DispatchQueue.main.async {
                    completion(.success(trainers))
                }
            } catch {
                print(NetworkError.decode)
            }
        }.resume()
    }
}
