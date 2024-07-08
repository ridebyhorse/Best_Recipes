//
//  HomeController.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit
import SwiftUI

typealias BannerRecipesCell = CollectionCell<BannerRecipesView>
typealias HeaderRecipesCell = CollectionCell<TitleRecipesView>
typealias CategoryCell = CollectionCell<CategoryView>
typealias CircleRecipesCell = CollectionCell<TimeCircleRecipesView>

//MARK: - class HomeControllerImpl
final class HomeControllerImpl: UIViewController {
    
    //MARK: - Presenter
    var presenter: (any HomePresenter)?
    
    //MARK: - Private properties
    private let searchController = Builder.createSearchScreen()
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }
}

//MARK: - class HomeController implement
extension HomeControllerImpl: HomeController {
    
    func update(with model: HomeViewModel?) {
        updateCollection(with: model!)
    }
}

extension HomeControllerImpl: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layoutSubviews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.layoutSubviews()
        
        guard let searchController = searchController.searchResultsController as? SearchControllerImpl else { return }
        guard let searchText = searchBar.text else { return }
        searchController.presenter?.searchRecipeByKeyword(searchText)
    }
}

private extension HomeControllerImpl {
    func configure() {
        setupViews()
        setupConstraints()
        searchController.searchBar.delegate = self
    }
    
    func setupViews() {
        view.addSubviews(collectionView)
        navigationItem.searchController = searchController
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
  
    func updateCollection(with model: HomeViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.trendigHeader, .trendingNow, .popularCategoryHeader, .categories, .circeRecipe])
        snapshot.appendItems([model.tandingNow.header], toSection: .trendigHeader)
        snapshot.appendItems(model.tandingNow.resepies, toSection: .trendingNow)
        snapshot.appendItems([model.popularCategory.header], toSection: .popularCategoryHeader)
        snapshot.appendItems(model.popularCategory.categories, toSection: .categories)
        snapshot.appendItems(model.popularCategory.resepies, toSection: .circeRecipe)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Create and Configure Priperties
private extension HomeControllerImpl {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(BannerRecipesCell.self, forCellWithReuseIdentifier: String(describing: BannerRecipesCell.self))
        collectionView.register(HeaderRecipesCell.self, forCellWithReuseIdentifier: String(describing: HeaderRecipesCell.self))
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        collectionView.register(CircleRecipesCell.self, forCellWithReuseIdentifier: String(describing: CircleRecipesCell.self))
        collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
            return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
                guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
                switch sectionType {
                case .trendingNow:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerRecipesCell.self), for: indexPath) as! BannerRecipesCell
                            if let recipeViewModel = item as? RecipesCellViewModel {
                            cell.update(with: recipeViewModel, didSelectHandler: recipeViewModel.didSelect)
                    }
                return cell
                case .trendigHeader, .popularCategoryHeader:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderRecipesCell.self), for: indexPath) as! HeaderRecipesCell
                            if let seeAllViewModel = item as? SeeAll {
                            cell.update(with: seeAllViewModel, didSelectHandler: nil)
                    }
                    return cell
                case .categories:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
                            if let seeAllViewModel = item as? Category {
                            cell.update(with: seeAllViewModel, didSelectHandler: nil)
                    }
                    return cell
                case .circeRecipe:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CircleRecipesCell.self), for: indexPath) as! CircleRecipesCell
                            if let seeAllViewModel = item as? RecipesCellViewModel {
                            cell.update(with: seeAllViewModel, didSelectHandler: nil)
                    }
                    return cell
                }
            }
        }
    
}

//MARK: - Create and Composional layout
private extension HomeControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        .init { sectionIndex, _ in
            let sectionType = Section(rawValue: sectionIndex)!
            switch sectionType {
            case .trendigHeader:
                return self.headerSetion()
            case .trendingNow:
                return self.createTrendingNowSection()
            case .popularCategoryHeader:
                return self.headerSetion()
            case .categories:
                return self.createCategorySection()
            case .circeRecipe:
                return self.createCircleRecipeSection()
            }
        }
    }
    
    func createTrendingNowSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top
//        )
//        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func headerSetion() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(0.05)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)

        return section
    }
    
    func createCircleRecipeSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.25)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
       
        
        
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top
//        )
//        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
private extension HomeControllerImpl {
    private enum Section: Int, CaseIterable {
        case trendigHeader
        case trendingNow
        case popularCategoryHeader
        case categories
        case circeRecipe
    }
}





extension HomeControllerImpl:  UICollectionViewDelegate {
       //    func collectionView(_ collectionView: UICollectinView, numberOfItemsInSection section: Int) -> Int {
//        switch sections[section] {
//        case .trendingNow(model: let model, header: let header):
//            return model.count
//        }
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        sections.count
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch sections[indexPath.section] {
//        case .trendingNow(model: let model, header: let header):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerRecipesCell.self), for: indexPath) as! BannerRecipesCell
//            cell.update(with: model[indexPath.row], didSelectHandler: model[indexPath.row].didSelect)
//            return cell
//        }
//    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}




//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: CustomTabBarController())
//}
