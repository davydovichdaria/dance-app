import UIKit
import CalendarKit

class ScheduleScreenVC: UIViewController {
    
    var mondayScheduleAPI = MondayScheduleImpl.init()
    var mondaySchedule: [Schedule] = []
    
    var tuesdayScheduleAPI = TuesdayScheduleImpl.init()
    var tuesdaySchedule: [Schedule] = []
    
    var wednesdayScheduleAPI = WednesdayScheduleImpl.init()
    var wednesdaySchedule: [Schedule] = []
    
    var thursdayScheduleAPI = ThursdayScheduleImpl.init()
    var thursdaySchedule: [Schedule] = []
    
    var fridayScheduleAPI = FridayScheduleImpl.init()
    var fridaySchedule: [Schedule] = []
    
    var saturdayScheduleAPI = SaturdayScheduleImpl.init()
    var saturdaySchedule: [Schedule] = []
    
    var sundayScheduleAPI = SundayScheduleImpl.init()
    var sundaySchedule: [Schedule] = []
    
    private var scheduleScreenView: ScheduleScreenView {
        return self.view as! ScheduleScreenView
    }
    
    override func loadView() {
        self.view = ScheduleScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
//        fetchMondaySchedule()
//        fetchTuesdaySchedule()
//        fetchWednesdaySchedule()
//        fetchThursdaySchedule()
//        fetchFridaySchedule()
//        fetchSaturdaySchedule()
        fetchSundaySchedule()
        
    }
    
    func fetchMondaySchedule() {
        Task {
            do {
                let scheduleResponse = try await mondayScheduleAPI.fetchSchedule()
                mondaySchedule = scheduleResponse.monday ?? []
                print(mondaySchedule.count)
                scheduleScreenView.updateSchedule(mondaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchTuesdaySchedule() {
        Task {
            do {
                let scheduleResponse = try await tuesdayScheduleAPI.fetchSchedule()
                tuesdaySchedule = scheduleResponse.tuesday ?? []
                print(tuesdaySchedule.count)
                scheduleScreenView.updateSchedule(tuesdaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchWednesdaySchedule() {
        Task {
            do {
                let scheduleResponse = try await wednesdayScheduleAPI.fetchSchedule()
                wednesdaySchedule = scheduleResponse.wednesday ?? []
                print(wednesdaySchedule.count)
                scheduleScreenView.updateSchedule(wednesdaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchThursdaySchedule() {
        Task {
            do {
                let scheduleResponse = try await thursdayScheduleAPI.fetchSchedule()
                thursdaySchedule = scheduleResponse.thursday ?? []
                print(thursdaySchedule.count)
                scheduleScreenView.updateSchedule(thursdaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    func fetchFridaySchedule() {
        Task {
            do {
                let scheduleResponse = try await fridayScheduleAPI.fetchSchedule()
                fridaySchedule = scheduleResponse.friday ?? []
                print(fridaySchedule.count)
                scheduleScreenView.updateSchedule(fridaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchSaturdaySchedule() {
        Task {
            do {
                let scheduleResponse = try await saturdayScheduleAPI.fetchSchedule()
                saturdaySchedule = scheduleResponse.saturday ?? []
                print(saturdaySchedule.count)
                scheduleScreenView.updateSchedule(saturdaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchSundaySchedule() {
        Task {
            do {
                let scheduleResponse = try await sundayScheduleAPI.fetchSchedule()
                sundaySchedule = scheduleResponse.sunday ?? []
                print(sundaySchedule.count)
                scheduleScreenView.updateSchedule(sundaySchedule)
                scheduleScreenView.scheduleTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    
}


