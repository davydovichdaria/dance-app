import UIKit

final class DetailScreenView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupViews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailScreenView {
    private func setupViews() {
        
        self.addSubview(detailScrollView)
        detailScrollView.addSubview(detailStackView)

    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            detailScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            detailScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: detailScrollView.topAnchor, constant: 0),
            detailStackView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor, constant: 0),
            detailStackView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor, constant: 0),
            detailStackView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor, constant: 0)
        ])
    }
}
