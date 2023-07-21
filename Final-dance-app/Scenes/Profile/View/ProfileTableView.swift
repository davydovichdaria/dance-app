import UIKit

class ProfileTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var classes: [DailyClasses]
    var onDeleteButtonTapped: (()->())?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = Colors().background
        self.allowsSelection = false
        self.separatorStyle = .none
        
        self.delegate = self
        self.dataSource = self
        
        self.register(ClassesTableViewCell.self, forCellReuseIdentifier: ClassesTableViewCell.reuseId)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassesTableViewCell.reuseId, for: indexPath) as! ClassesTableViewCell
        let lesson = classes[indexPath.row]
        
        
        cell.update(lesson)
        
        cell.deleteView.addTarget(self, action: #selector(lessonDeleted), for: .valueChanged)
        return cell
    }
    
    @objc func lessonDeleted(counter: DeleteView) {
        deleteClass(counter: counter)
    }
    
    func deleteClass(counter: DeleteView) {
        classes[counter.index].count = counter.currentValue
        
        if counter.currentValue == 0 {
            classes.remove(at: counter.index)
        }
        self.reloadData()
        classesArchiver.save(classes)
    }
    
}
