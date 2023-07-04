import UIKit

final class ScheduleTableView: UITableView {
    
    var schedule: [Schedule] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        self.backgroundColor = .lightGray.withAlphaComponent(0.1)
        self.separatorColor = .gray.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorInset.left = 100
        self.separatorInset.right = 10
        self.allowsSelection = false

        
        self.dataSource = self
        self.delegate = self
        
        self.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ schedule: [Schedule]) {
        self.schedule = schedule
    }
}

extension ScheduleTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseId, for: indexPath) as! ScheduleTableViewCell
        
        let schedule = schedule[indexPath.row]
        
        cell.update(schedule)
        return cell
    }
}
