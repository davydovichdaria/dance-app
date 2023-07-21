import Foundation
import Combine

class ProfileViewModel {
    
    struct Input {
        var signal: AnyPublisher<ViewSignal, Never>
    }
    
    struct Output {
        var classes: AnyPublisher<[DailyClasses], Never>
    }
    
    private var input: Input!
    var output: Output!
    
    private var classesPublisher = PassthroughSubject<[DailyClasses], Never>()
    private var subscription = Set<AnyCancellable>()
    
    private var classesArchiver = ClassesRepositoryImpl()
    
//    lazy var classes: [DailyClasses] = classesArchiver.retrive()
    
    init() {
        self.output = .init(classes: classesPublisher.eraseToAnyPublisher())
    }
    
    func bind(signal: AnyPublisher<ViewSignal, Never>) -> Output {
        self.input = .init(signal: signal)
        
        input.signal
            .receive(on: RunLoop.main)
            .sink { signal in
                switch signal {
                case .fetchClasses:
//                    self.classes = self.classesArchiver.retrive()
                    self.fetchClasses()
            }
            .store(in: &subscription)
        
        return output
    }
    
   private func fetchClasses() {
       let classes = self.classesArchiver.retrive()
       classesPublisher.send(classes)
    }
    
}

extension ProfileViewModel {
    enum ViewSignal {
        case fetchClasses
        case saveClasses
        case deleteClass
    }
}
