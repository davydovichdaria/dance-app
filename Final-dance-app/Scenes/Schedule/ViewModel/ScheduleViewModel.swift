import Foundation
import Combine

class ScheduleViewModel {
    
    struct Input { //сигнал
        var signal: AnyPublisher<ViewSignal, Never>
    }
    
    struct Output { //то что отдаем - массив schedule
        var schedule: AnyPublisher<[Schedule], Never>
    }
    
    private var input: Input!
    var output: Output!
    
    // Паблишер умеет отправлять и принимать данные
    // Аутпуту нужно только то что сможет принимать
    // Поэтому в эту приватную проперти МЫ ОТПРАВЛЯЕМ ДАННЫЕ
    // А кто-то через АУТПУТ на это подписывается
    private var schedulePublisher = PassthroughSubject<[Schedule], Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var scheduleAPI = ScheduleAPIImpl.init()
    
    init() {
        self.output = .init(schedule: schedulePublisher.eraseToAnyPublisher())
    }
    
    func bind(
        signal: AnyPublisher<ViewSignal, Never>
    ) -> Output {
        self.input = .init(signal: signal)
        
        input.signal
            .receive(on: RunLoop.main)
            .sink { signal in
                switch signal {
                case .initialLoading:
                    self.handleInitialLoading()
                case let .reload(day):
                    self.handleReloadSignal(with: day)
                }
            }
            .store(in: &subscriptions)
        
        return output
    }
    
    // MARK: - Signals handling
    
    private func handleInitialLoading() {
        let todayDayIndex = returnWeekDay()
        self.fetchDailySchedule(day: todayDayIndex)
    }
    
    private func handleReloadSignal(with day: Int) {
        self.fetchDailySchedule(day: day)
    }
    
    // MARK: - Private logic
    
    func returnWeekDay() -> Int {
        let calendar = Calendar.autoupdatingCurrent
        let dateNow = Date()
        let dayOfWeek = calendar.component(.weekday, from: dateNow)
        return dayOfWeek
    }
    
    func fetchDailySchedule(day: Int) {
            let weekDay = Days.init(rawValue: day)
            
            switch weekDay  {
            case .sunday: fetchDaySchedule(endpoint: ScheduleEndpoint.getSunday)
            case .monday: fetchDaySchedule(endpoint: ScheduleEndpoint.getMonday)
            case .tuesday: fetchDaySchedule(endpoint: ScheduleEndpoint.getTuesday)
            case .wednesday: fetchDaySchedule(endpoint: ScheduleEndpoint.getWednesday)
            case .thursday: fetchDaySchedule(endpoint: ScheduleEndpoint.getThursday)
            case .friday: fetchDaySchedule(endpoint: ScheduleEndpoint.getFriday)
            case .saturday: fetchDaySchedule(endpoint: ScheduleEndpoint.getSaturday)
            default: print("No data")
            }
        }
    
    func fetchDaySchedule(endpoint: Endpoint) {
        Task {
            do {
                let scheduleResponse = try await scheduleAPI.fetchSchedule(endpoint: endpoint)
                let schedule = scheduleResponse.schedule
                schedulePublisher.send(schedule)
            } catch {
                print(error)
            }
        }
    }
}

extension ScheduleViewModel {
    
    enum ViewSignal {
        case initialLoading
        case reload(Int)
    }
}
