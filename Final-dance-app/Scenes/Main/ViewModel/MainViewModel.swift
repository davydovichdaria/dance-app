import Foundation
import Combine

class MainViewModel {
    
    struct Input {
        var signal: AnyPublisher<ViewSignal, Never>
    }
    
    struct Output {
    }
    
    private var input: Input!
    var output: Output!
    
}

extension MainViewModel {
    enum ViewSignal {
        
    }
}

