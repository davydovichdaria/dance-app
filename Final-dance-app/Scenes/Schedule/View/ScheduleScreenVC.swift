import UIKit
import CalendarKit
import Combine

class ScheduleScreenVC: UIViewController {

    // MARK: - MVVM
    
    private var viewModel = ScheduleViewModel()
    private var viewSignal = PassthroughSubject<ScheduleViewModel.ViewSignal, Never>()
    private var subscription = Set<AnyCancellable>()
    
    private lazy var calendarState: DayViewState = {
        let state = DayViewState(date: Date(), calendar: Calendar.autoupdatingCurrent)
        state.subscribe(client: self)
        return state
    }()
    
    lazy var calendarView: DayHeaderView = {
        let calendar = Calendar.autoupdatingCurrent
        var calendarView = DayHeaderView(calendar: calendar)
        calendarView.state = calendarState
        
        var style = DayHeaderStyle()
        style.daySelector.inactiveBackgroundColor = .white
        style.daySelector.inactiveTextColor = .black
        style.daySelector.todayActiveBackgroundColor = UIColor(named: "dark purple") ?? .systemPink
        style.daySelector.todayActiveTextColor = .white
        style.daySelector.selectedBackgroundColor = UIColor(named: "dark purple") ?? .systemPink
        style.daySelector.activeTextColor = .white
        style.daySelector.todayInactiveTextColor = .black
        
        calendarView.updateStyle(style)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarView
    }()
    
    var scheduleTableView = ScheduleTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        
        setupViews()
        setupConstraints()
        
        bind()
        viewSignal.send(.initialLoading)
        
        // Navigation
        scheduleTableView.onClassesCellSelected = { classes in
            self.showDetailClasses(classes)
        }
    }
    
    func showDetailClasses(_ lesson: Schedule) {
        let controller = DetailScreenVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//MARK: - Public
    
    public func bind() {
        let output = viewModel.bind(signal: viewSignal.eraseToAnyPublisher())
        
        output.schedule
            .receive(on: RunLoop.main)
            .sink { schedule in
                self.scheduleTableView.update(schedule)
                self.scheduleTableView.reloadData()
            }
            .store(in: &subscription)
    }
}

//MARK: - Layout configuration

extension ScheduleScreenVC {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
        view.addSubview(scheduleTableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            scheduleTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


//MARK: - DayViewStateUpdating

extension ScheduleScreenVC: DayViewStateUpdating {
    
    func move(from oldDate: Date, to newDate: Date) {
        print("$0: \(newDate)")
        let calendar = Calendar.autoupdatingCurrent
        let dayOfWeek = calendar.component(.weekday, from: newDate)
        viewSignal.send(.reload(dayOfWeek))
    }
}
