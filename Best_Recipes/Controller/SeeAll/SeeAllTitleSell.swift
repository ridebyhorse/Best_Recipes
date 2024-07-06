import UIKit

class SeeAllTitleSell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "SeeAllTitleSell"
    
    let friendImageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purple
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBlue
        label.frame = self.bounds
        backgroundColor = .systemTeal
    }
    
    func configure(with intValue: Int) {
        label.text = String(intValue)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
