import UIKit

enum RecipesType {
    case tradingNow
    case recentRecipe
    case popularCreators
}

final class SeeAllViewController: UIViewController {
    
    private var type: RecipesType
    
    private var data = MockData()
    
    init(type: RecipesType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var collectionView: UICollectionView!
    
    private let customView = SeeAllView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.setTitle(type)
        customView.setDelegates(value: self)
    }
    
    override func loadView() {
        
        view = customView
    }
}


extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAllCell", for: indexPath) as! SeeAllCell
        
        let item = data[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }
}

