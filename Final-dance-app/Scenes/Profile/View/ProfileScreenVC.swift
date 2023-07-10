import UIKit

class ProfileScreenVC: UIViewController {

    var profileCardView: UIView = {
       var view = CardView.init()
        view.cardImageView.heightAnchor.constraint(equalToConstant: Screen.width * 0.25).isActive = true
        view.cardImageView.layer.cornerRadius = 15
        view.cardImageView.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = Colors().background
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.addSubview(profileCardView)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    
}
