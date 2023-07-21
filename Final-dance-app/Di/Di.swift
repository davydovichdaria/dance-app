import UIKit

protocol ScheduleApiClient {
    
}

class ScheduleApiClientImpl: ScheduleApiClient {
    
}

protocol TrainersApiClient {
    
}

class TrainersApiClientImpl: TrainersApiClient {
    
}



protocol ScreenFactory {
    
    var di: Di! { get set }
    
    func makeMainTabVC() -> MainTabVC
    
    func makeMainScreen() -> MainScreenVC
    func makeScheduleScreen() -> ScheduleScreenVC
    func makeTrainerScreen() -> TrainersScreenVC
    func makeAboutScreen() -> AboutScreenVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    weak var di: Di!
    
    func makeMainTabVC() -> MainTabVC {
        return MainTabVC()
    }
    
    func makeMainScreen() -> MainScreenVC {
        return MainScreenVC.init(provider: di.mainProvider)
    }
    
    func makeScheduleScreen() -> ScheduleScreenVC {
        return ScheduleScreenVC.init()
    }
    
    func makeTrainerScreen() -> TrainersScreenVC {
        return TrainersScreenVC.init()
    }
    
    func makeAboutScreen() -> AboutScreenVC {
        return AboutScreenVC.init()
    }
}

class Di {
    
    static let shared = Di.init()
    
    let scheduleApiClient: ScheduleApiClient
    
    let trainersApiClient: TrainersApiClient
    
    let classesRepository: ClassesRepository
    
    var screenFactory: ScreenFactory
    
    init() {
        scheduleApiClient = ScheduleApiClientImpl()
        trainersApiClient = TrainersApiClientImpl()
        classesRepository = ClassesRepositoryImpl()
        screenFactory = ScreenFactoryImpl()
        
        screenFactory.di = self
    }
    
    //упаковали провайдер
    var mainProvider: MainProviderImpl {
        return MainProviderImpl.init(repository: classesRepository)
    }
}

extension Di {
    func makeWindowWithController(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow.init(windowScene: scene)
        
        let rootVC = screenFactory.makeMainTabVC()
        window.rootViewController = rootVC
        return window
    }
}
