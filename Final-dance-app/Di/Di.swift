import UIKit

class Di {
    
    static let shared = Di.init()
    
    let userService: UserService
    
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
        userService = UserService()
        
        screenFactory.di = self
    }
    
    var mainProvider: MainProviderImpl {
        return MainProviderImpl.init(repository: classesRepository)
    }
    
    var scheduleProvider: ScheduleProviderImpl {
        return ScheduleProviderImpl(dayService: dayService, scheduleApi: scheduleApiClient)
    }
    
    var detailProvider: DetailProviderImpl {
        return DetailProviderImpl(repository: classesRepository)
    }
    
    var trainersProvider: TrainersProviderImpl {
        return TrainersProviderImpl(trainersApi: trainersApiClient)
    }
    
    var profileProvider: ProfileProviderImpl {
        return ProfileProviderImpl(classesArchiver: classesRepository)
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
