import UIKit


final class SeeAllCell: UICollectionViewCell {
    
    var item = SeeAllCell()
    
    private let ratingLabel = Rating.makeRating(
        image: UIImageView(image: UIImage(resource: .star)),
        ratingLabel: "5,0",
        blur: true
    )
    
    private let titleLabel = Label.makeTitleLabel(text: "")
    
    private let descriptionLabel = Label.makeScreenValueLabel(text: "")
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup View
    private func setupView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    
    func configure(with item: item) {
        titleLabel.text = item.title
        imageView.image = item.coverImage
        descriptionLabel.text = "\(item.category.rawValue.count) ingradients | \(item.time) min"
    }
    
    
    
}

extension SeeAllCell {
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 400),
        ])
    }
}


final class Rating {
    static func makeRating(image:UIImageView, ratingLabel:String, blur:Bool = true) -> UIView {
        let ratingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 58, height: 28)))
        ratingView.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = ratingView.frame
        
        let localImage = image
        localImage.contentMode = .scaleAspectFit
        localImage.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.textColor = blur ? UIColor.white : UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = ratingLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        ratingView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(localImage)
        blurEffectView.contentView.addSubview(label)
        if !blur {
            label.textColor = UIColor.blue
            ratingView.addSubview(localImage)
            ratingView.addSubview(label)
            blurEffectView.effect = nil
        }
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            localImage.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            localImage.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 8),
            localImage.widthAnchor.constraint(equalToConstant: 16),
            localImage.heightAnchor.constraint(equalToConstant: 16),
            
            label.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: localImage.trailingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -8),
        ])
        
        return ratingView
    }
}



final class Label {
    
    static func makeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    static func makeScreenValueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.custom(font: .regular, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
        
        
    }
    
    static func makeScreenTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.custom(font: .regular, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
}
