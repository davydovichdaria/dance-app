import UIKit

class TrainersTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    
    static let reuseID = "TrainersTableViewCell"
    
    var trainers: [Trainer] = []
    
    var containerView: UIView = {
        var view = UIView()
        view.heightAnchor.constraint(equalToConstant: Screen.width).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors().background
        return view
    }()
    
    var titleLabel = Label(style: .typesOfClasses, text: "Our trainers")
    
    lazy var trainersCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: Screen.width * 0.5, height: Screen.width * 0.7)
        layout.minimumLineSpacing = 20
        
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Colors().background
        
        collectionView.register(TrainersCollectionViewCell.self, forCellWithReuseIdentifier: TrainersCollectionViewCell.reuseId)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ trainers: [Trainer]) {
        self.trainers = trainers
    }
    
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(trainersCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            trainersCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            trainersCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            trainersCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            trainersCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(trainers.count)
        return trainers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainersCollectionViewCell.reuseId, for: indexPath) as! TrainersCollectionViewCell
        let trainer = trainers[indexPath.row]
        cell.update(trainer)
        return cell
    }
}
