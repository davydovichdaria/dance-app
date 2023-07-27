import Foundation

protocol TrainersProvider {
    var onTrainersLoaded: (([Trainer])->())? { get set }
    
    func fetchTrainers()
}

class TrainersProviderImpl: TrainersProvider {
    let trainersApi: TrainersApiClient
    var onTrainersLoaded: (([Trainer])->())?
    
    init(trainersApi: TrainersApiClient) {
        self.trainersApi = trainersApi
    }
    
    func fetchTrainers() {
        
        trainersApi.fetchSchedule(endpoint: TrainersEndpoint.getTrainers) { result in
            switch result {
            case .success(let trainers):
                self.onTrainersLoaded?(trainers)
            case .failure(_):
                print("Error")
            }
        }
    }
}
