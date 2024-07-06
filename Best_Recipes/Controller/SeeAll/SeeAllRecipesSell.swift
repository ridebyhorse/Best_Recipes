import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with intValue: Int)
}

class SeeAllRecipesSell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "SeeAllRecipesSell"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purple
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.backgroundColor = .systemPink
        addSubview(friendImageView)
        friendImageView.frame = self.bounds
    }
    
    func configure(with intValue: Int) {
        print("123")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
