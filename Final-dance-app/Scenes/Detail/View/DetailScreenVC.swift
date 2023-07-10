import UIKit

class DetailScreenVC: UIViewController {
        
        private let detailScrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.backgroundColor = .systemPink.withAlphaComponent(0.5)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        private let detailStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Layout configuration
extension DetailScreenVC {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(detailStackView)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            detailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: detailScrollView.topAnchor, constant: 0),
            detailStackView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor, constant: 0),
            detailStackView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor, constant: 0),
            detailStackView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0)
        ])
    }
}
