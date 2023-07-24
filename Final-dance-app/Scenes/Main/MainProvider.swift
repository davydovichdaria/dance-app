import Foundation

protocol MainProvider {
    
    var repository: ClassesRepository { get set }
}

class MainProviderImpl: MainProvider {
    
    var repository: ClassesRepository
    
    init(repository: ClassesRepository) {
        self.repository = repository
    }
}
