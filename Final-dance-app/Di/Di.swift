import UIKit

protocol ScreenFactory {
    
    var di: Di! { get set }
    
    func makeMainTabVC() -> MainTabVC
    func makeMainScreen() -> MainScreenVC
    func makeTrainerScreen() -> TrainersScreenVC
    func makeScheduleScreen() -> ScheduleScreenVC
    func makeAboutScreen() -> AboutScreenVC
    func makeProfileScreen() -> ProfileScreenVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    weak var di: Di!
    
    func makeMainTabVC() -> MainTabVC {
        return MainTabVC()
    }
    
    func makeMainScreen() -> MainScreenVC {
        return MainScreenVC.init(provider: di.mainProvider)
    }
    
    func makeTrainerScreen() -> TrainersScreenVC {
        return TrainersScreenVC.init(trainersAPI: di.trainersApiClient)
    }
    
    func makeScheduleScreen() -> ScheduleScreenVC {
        return ScheduleScreenVC.init(scheduleProvider: di.scheduleProvider)
    }
    
    func makeAboutScreen() -> AboutScreenVC {
        return AboutScreenVC.init()
    }
    
    func makeProfileScreen() -> ProfileScreenVC {
        return ProfileScreenVC.init()
    }
}

class Di {
    
    static let shared = Di.init()
    
    let scheduleApiClient: ScheduleApiClient
    
    let trainersApiClient: TrainersApiClient
    
    let classesRepository: ClassesRepository
    
    let dayService: DayService
    
    var screenFactory: ScreenFactory
    
    init() {
        scheduleApiClient = ScheduleApiClientImpl()
        trainersApiClient = TrainersApiClientImpl()
        classesRepository = ClassesRepositoryImpl()
        dayService = DayServiceImpl()
        screenFactory = ScreenFactoryImpl()
        
        screenFactory.di = self
    }
    
    //упаковали провайдер
    var mainProvider: MainProviderImpl {
        return MainProviderImpl.init(repository: classesRepository)
    }
    
    var scheduleProvider: ScheduleProviderImpl {
        return ScheduleProviderImpl(dayService: dayService, scheduleApi: scheduleApiClient)
    }
}

protocol ScheduleProvider {
    var dayService: DayService { get set }
    var scheduleApi: ScheduleApiClient { get set }
}

class ScheduleProviderImpl: ScheduleProvider {
    var dayService: DayService
    var scheduleApi: ScheduleApiClient
    
    init(dayService: DayService, scheduleApi: ScheduleApiClient) {
        self.dayService = dayService
        self.scheduleApi = scheduleApi
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
