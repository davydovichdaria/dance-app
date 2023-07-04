import UIKit

protocol ScreenFactory {
    func makeMainScreen() -> MainScreenVC
    func makeScheduleScreen() -> ScheduleScreenVC
    func makeProfileScreen() -> ProfileScreenVC
}

final class ScreenFactoryImpl: ScreenFactory {
    
    weak var di: DependencyContainer!
    
    init() {}
    
    func makeMainScreen() -> MainScreenVC {
        return MainScreenVC.init()
    }
    
    func makeScheduleScreen() -> ScheduleScreenVC {
        return ScheduleScreenVC.init()
    }
    
    func makeProfileScreen() -> ProfileScreenVC {
        return ProfileScreenVC.init()
    }
    
    
}