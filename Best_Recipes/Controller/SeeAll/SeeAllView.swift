import UIKit

final class SeeAllView: UIView {
    
    private let title = Label.makeScreenTitleLabel(text: "")
    
    
    private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 200)
        layout.minimumLineSpacing = 24
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 15
        collectionView.register(SeeAllCell.self, forCellWithReuseIdentifier: "SeeAllCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ type: RecipesType) {
        switch type {
        case .tradingNow:
            title.text = "tradingNow"
        case .recentRecipe:
            title.text = "recentRecipe"
        case .popularCreators:
            title.text = "popularCreators"
        }
    }
    
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setDelegates(value: SeeAllViewController) {
        collectionView.delegate = value
        collectionView.dataSource = value
    }
    
    private func setViews() {
        
        addSubview(collectionView)
    }
}
