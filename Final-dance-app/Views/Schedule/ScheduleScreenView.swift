import UIKit
import CalendarKit

class ScheduleScreenView: UIView {
    
    var calendarView = DayHeaderView(calendar: Calendar.autoupdatingCurrent)
    
    private func configureLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        calendarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        let heightConstraint = calendarView.heightAnchor.constraint(equalToConstant: 70)
            heightConstraint.isActive = true
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(calendarView)
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
////            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//        ])
    }
}
