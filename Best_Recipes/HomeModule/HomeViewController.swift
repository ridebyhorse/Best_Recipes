//
//  HomeController.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit

//MARK: - class HomeControllerImpl
final class HomeControllerImpl: UIViewController {
    //MARK: - Presenter
    var presenter: (any HomePresenter)?
    
    //MARK: - Private properties
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    
}

//MARK: - class HomeController implement
extension HomeControllerImpl: HomeController {
   
    func update(with model: HomeViewModel?) {
        
    }
}

//MARK: - Create and Configure any Views
private extension HomeControllerImpl {
     func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(BannerRecipesCell.self, forCellWithReuseIdentifier: String(describing: BannerRecipesCell.self))
        
        return collectionView
    }
}

//MARK: - Create and Composional layout
private extension HomeControllerImpl {
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        .init() {
            sectionIndex, _ in
            switch Sections(rawValue: sectionIndex) {
                
            case .trendingNow:
                let screenWidth = UIScreen.main.bounds.width
                let cellWidth: CGFloat = 140
                let cellHeight: CGFloat = 250
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(cellWidth),
                    heightDimension: .estimated(cellWidth * 2.3)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(1.0),
                    heightDimension: .estimated(1.0 * 2)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return section
            default:
                let screenWidth = UIScreen.main.bounds.width
                let cellWidth: CGFloat = 140
                let cellHeight: CGFloat = 250
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(cellWidth),
                    heightDimension: .estimated(cellWidth * 2.3)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(1.0),
                    heightDimension: .estimated(1.0 * 2)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return section
            }
        }
        
    }
    
}
private extension HomeControllerImpl {
    private enum Sections: Int {
        case trendingNow
    }
}

typealias BannerRecipesCell = CollectionCell<BannerRecipesView>
