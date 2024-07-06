import UIKit

class SeeAllViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case grid, list
        var columnCount: Int {
            switch self {
            case .grid:
                return 3
            case .list:
                return 2
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(SeeAllTitleSell.self, forCellWithReuseIdentifier: SeeAllTitleSell.reuseId)
        
        collectionView.register(SeeAllRecipesSell.self, forCellWithReuseIdentifier: SeeAllRecipesSell.reuseId)
        
        
        setupDataSource()
        reloadData()
        
        collectionView.delegate = self
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Error \(cellType)")
        }
        return cell
    }
    
    // MARK: - Manage the data in UICV
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, intValue) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
            case .list:
                return self.configure(cellType: SeeAllRecipesSell.self, with: intValue, for: indexPath)
            case .grid:
                return self.configure(cellType: SeeAllTitleSell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        let itemPerSection = 10
        SectionKind.allCases.forEach { (sectionKind) in
            let itemOffSet = sectionKind.columnCount * itemPerSection
            let itemUpperbound = itemOffSet + itemPerSection
            snapshot.appendSections([sectionKind])
            snapshot.appendItems(Array(itemOffSet..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Setup Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .grid:
                return self.createGridSection()
            case .list:
                return self.createListSection()

            }
        }
        
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
        
        return layout
    }
    
    private func createGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                     heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 12, bottom: 0, trailing: 12)
        
        return layoutSection
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let spacing = CGFloat(24)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        return section
    }
    

}

// MARK: - UICollectionViewDelegate
extension SeeAllViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
// MARK: - SwiftUI
import SwiftUI
struct SeeAllProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = CustomTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<SeeAllProvider.ContainterView>) -> CustomTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController: SeeAllProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<SeeAllProvider.ContainterView>) {
            
        }
    }
}
