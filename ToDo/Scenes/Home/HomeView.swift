import UIKit

class HomeView: UIView {

    lazy var TasksCollections: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomTaskCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        root()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
    private func addSubviews(){
        addSubview(TasksCollections)
        
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            TasksCollections.topAnchor.constraint(equalTo: topAnchor),
            TasksCollections.leadingAnchor.constraint(equalTo: leadingAnchor),
            TasksCollections.trailingAnchor.constraint(equalTo: trailingAnchor),
            TasksCollections.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func root(){
        backgroundColor = .white
    }
}
