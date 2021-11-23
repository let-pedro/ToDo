import UIKit

class CustomTaskCell: UICollectionViewCell {
    
    lazy var emoji: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var data: Task? {
        didSet {
            guard let data = data else { return }
            emoji.text = data.emoji
            title.text = data.title
        }
    }
}


extension CustomTaskCell {
    
    private func addSubviews(){
        addSubview(emoji)
        addSubview(title)
        
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            emoji.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            emoji.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: emoji.trailingAnchor, constant: 24),
        ])
    }
}
