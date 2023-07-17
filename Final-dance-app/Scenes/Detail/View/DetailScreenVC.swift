import UIKit
import CalendarKit

class DetailScreenVC: UIViewController {
    
    var currentClass: Schedule
    var tappedDay: DayViewState
    var classesArchiver = ClassesRepositoryImpl()
    var profileVC = ProfileScreenVC()
    
    lazy private var detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = Colors().background
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var detailStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var styleImageView: UIImageView = {
        var imageView = UIImageView.init()
        imageView.image = UIImage(named: "High Heels")
        imageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.5).isActive = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   lazy private var infoClassesView = InfoClassesView.init()
    private var trainerDetailView = TrainerDetailView.init()
    private var signUpView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.widthAnchor.constraint(equalToConstant: Screen.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: 75).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sing up for a workout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "dark purple")
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 50, bottom: 5, right: 50)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()

    init(classes: Schedule, selectedDay: DayViewState) {
        self.currentClass = classes
        self.tappedDay = selectedDay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        
        setupViews()
        setupConstraints()
        
        
    }
    
    @objc func signUpButtonTapped() {
        signUpToWorkout()
    }
    
    func update() {

            infoClassesView.update(currentClass, day: self.tappedDay)
            trainerDetailView.update(currentClass)
            updateImageView(currentClass)
        
    }
    
    func signUpToWorkout() {
        var futureClasses = classesArchiver.retrive() //Получили массив из хранилища
        
        let selectedLesson = DailyClasses(lesson: currentClass, day: fetchSelectedDay())
        
        let isRepeatedClasses = futureClasses.contains { $0.day == selectedLesson.day && $0.lesson.time == selectedLesson.lesson.time}
        
        defer {
            classesArchiver.save(futureClasses)
            profileVC.classesTableView.reloadData()
            print(futureClasses.count)
        }
        
        if futureClasses.isEmpty || !isRepeatedClasses {
            futureClasses.append(selectedLesson)
            selectedLesson.count = 1
            return //Возвращаемся к defer и выходим из функции
        }
    }
    
    func fetchSelectedDay() -> String {
        let calendar = Calendar.autoupdatingCurrent
        let date = tappedDay.selectedDate
//        let dayOfWeek = calendar.dateComponents([.day, .weekday, .month], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
    
    func updateImageView(_ lesson: Schedule) {
        styleImageView.image = UIImage(named: lesson.name)
    }
}

//MARK: - Layout configuration
extension DetailScreenVC {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailStackView)
        
        detailStackView.addArrangedSubview(styleImageView)
        detailStackView.addArrangedSubview(infoClassesView)
        detailStackView.addArrangedSubview(trainerDetailView)
        
        view.addSubview(signUpView)
        signUpView.addSubview(signUpButton)

    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            detailScrollView.bottomAnchor.constraint(equalTo: signUpView.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: detailScrollView.topAnchor, constant: 0),
            detailStackView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor, constant: 0),
            detailStackView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor, constant: 0),
            detailStackView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0),
            detailStackView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            signUpView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signUpView.topAnchor, constant: 15),
            signUpButton.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor, constant: -15),
            signUpButton.bottomAnchor.constraint(equalTo: signUpView.bottomAnchor, constant: -15)
        ])
    }
}
