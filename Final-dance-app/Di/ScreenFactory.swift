import Foundation
import CalendarKit

protocol ScreenFactory {
    
    var di: Di! { get set }
    
    func makeAuthorizationScreen() -> AuthorizationScreenVC
    
    func makeMainTabVC() -> MainTabVC
    func makeMainScreen() -> MainScreenVC
    func makeTrainerScreen() -> TrainersScreenVC
    func makeScheduleScreen() -> ScheduleScreenVC
    func makeAboutScreen() -> AboutScreenVC
    func makeProfileScreen() -> ProfileScreenVC
    func makeDetailScreen(classes: Schedule, selectedDay: DayViewState) -> DetailScreenVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    weak var di: Di!
    
    func makeAuthorizationScreen() -> AuthorizationScreenVC {
        return AuthorizationScreenVC()
    }
    
    func makeMainTabVC() -> MainTabVC {
        return MainTabVC()
    }
    
    func makeMainScreen() -> MainScreenVC {
        return MainScreenVC.init(provider: di.mainProvider)
    }
    
    func makeTrainerScreen() -> TrainersScreenVC {
        return TrainersScreenVC.init(trainersProvider: di.trainersProvider)
    }
    
    func makeScheduleScreen() -> ScheduleScreenVC {
        return ScheduleScreenVC.init(scheduleProvider: di.scheduleProvider)
    }
    
    func makeAboutScreen() -> AboutScreenVC {
        return AboutScreenVC.init()
    }
    
    func makeProfileScreen() -> ProfileScreenVC {
        return ProfileScreenVC.init(profileProvider: di.profileProvider)
    }
    
    func makeDetailScreen(classes: Schedule, selectedDay: DayViewState) -> DetailScreenVC {
        return DetailScreenVC(classes: classes, selectedDay: selectedDay, detailProvider: di.detailProvider)
    }
}
