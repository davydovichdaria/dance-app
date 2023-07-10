import Foundation
import Combine

class TrainersViewModel {
    
    struct Input { //принимаемый сигнал
        var signal: AnyPublisher<ViewSignal, Never>
    }
    
    struct Output {
        var trainers: AnyPublisher<[Trainer], Never>
    }
    
    private var input: Input!
    var output: Output!
    
    private var trainersPublisher = PassthroughSubject<[Trainer], Never>()
    
    private var subscription = Set<AnyCancellable>()
    
    private var trainersAPI = TrainersAPIImpl.init()
    
    init() {
        self.output = .init(trainers: trainersPublisher.eraseToAnyPublisher())
    }
    
    func bind(signal: AnyPublisher<ViewSignal, Never>) -> Output {
        self.input = .init(signal: signal)
        
        input.signal
            .receive(on: RunLoop.main)
            .sink { signal in
                switch signal {
                case .initialLoading:
                    self.handleInitialLoading()
                }
            }
            .store(in: &subscription)
        return output
    }
    
    //MARK: - Signal handling
    
    private func handleInitialLoading() {
        self.fetchTrainers()
    }
    
    
    func fetchTrainers() {
        Task {
            do {
                let trainersResponse = try await trainersAPI.fetchTrainers()
                let trainers = trainersResponse.trainers
                trainersPublisher.send(trainers)
//                trainersTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    
}

extension TrainersViewModel {
    enum ViewSignal {
        case initialLoading
    }
}
