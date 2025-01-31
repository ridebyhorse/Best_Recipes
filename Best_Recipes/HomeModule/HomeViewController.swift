//
//  HomeController.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit

typealias BannerRecipesCell = CollectionCell<BannerRecipesView>
typealias HeaderRecipesCell = CollectionCell<TitleRecipesView>
typealias CategoryCell = CollectionCell<CategoryView>
typealias CircleRecipesCell = CollectionCell<TimeCircleRecipesView>
typealias RecentRecipesCell = CollectionCell<RecentRecipeView>
typealias CountryCell = CollectionCell<CountryCategoryView>

//MARK: - class HomeControllerImpl
final class HomeControllerImpl: UIViewController {
    
    //MARK: - Presenter
    var presenter: (any HomePresenter)?
    
    //MARK: - Private properties
    private var isFirstLoad = true
    var searchController: UISearchController?
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    private var selectedIndexPaths: [Int: IndexPath] = [:]
    
    private let loadingIndicator: UIActivityIndicatorView = createLoadingView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidApear()
    }
}

//MARK: - class HomeController implement
extension HomeControllerImpl: HomeController {
    
    func update(with model: HomeViewModel?) {
        updateCollection(with: model!)
        
        hideLoadingIndicator()
        
        if !model!.popularCategory.resepies.isEmpty, isFirstLoad {
            let indexPath = IndexPath(row: 0, section: Section.categories.rawValue)
            selectedIndexPaths[Section.categories.rawValue] = indexPath
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            isFirstLoad = false
        } else {
            selectedIndexPaths.forEach { (key: Int, value: IndexPath) in
                collectionView.selectItem(at: value, animated: false, scrollPosition: [])
            }
        }
    }
}

//MARK: - UISearchBarDelegate
extension HomeControllerImpl: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layoutSubviews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.layoutSubviews()
        
        guard let searchController = searchController!.searchResultsController as? SearchControllerImpl else { return }
        guard let searchText = searchBar.text else { return }
        searchController.presenter?.searchRecipeByKeyword(searchText)
    }
    
}

//MARK: - UISearchControllerDelegate
extension HomeControllerImpl: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        view.isUserInteractionEnabled = false
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        view.isUserInteractionEnabled = true
    }
    
}

private extension HomeControllerImpl {
    func configure() {
        setupViews()
        setupConstraints()
        showLoadingIndicator()
        searchController?.searchBar.delegate = self
        searchController?.delegate = self
    }
    
    func setupViews() {
        view.addSubviews(collectionView, loadingIndicator)
        navigationItem.searchController = searchController
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func updateCollection(with model: HomeViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.trendigHeader, .trendingNow, .popularCategoryHeader, .categories, .circeRecipe, .recentRecipeHeader, .recentRecipe, .countryHeader , .country])
        snapshot.appendItems([model.tandingNow.header], toSection: .trendigHeader)
        snapshot.appendItems(model.tandingNow.resepies, toSection: .trendingNow)
        
        snapshot.appendItems([model.popularCategory.header], toSection: .popularCategoryHeader)
        snapshot.appendItems(model.popularCategory.categories, toSection: .categories)
        
        snapshot.appendItems(model.popularCategory.resepies, toSection: .circeRecipe)
        
        if !model.recentRecipe.resepies.isEmpty {
            snapshot.appendItems([model.recentRecipe.header], toSection: .recentRecipeHeader)
            snapshot.appendItems(model.recentRecipe.resepies, toSection: .recentRecipe)
            
        }
        snapshot.appendItems([model.country.header], toSection: .countryHeader)
        snapshot.appendItems(model.country.country, toSection: .country)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - Create and Configure Properties
private extension HomeControllerImpl {
    func createCollectionView() -> UICollectionView {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(SeeAllRecipesCell.self, forCellWithReuseIdentifier: String(describing: SeeAllRecipesCell.self))
        collectionView.register(HeaderRecipesCell.self, forCellWithReuseIdentifier: String(describing: HeaderRecipesCell.self))
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        collectionView.register(CircleRecipesCell.self, forCellWithReuseIdentifier: String(describing: CircleRecipesCell.self))
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: String(describing: CountryCell.self))
        collectionView.register(RecentRecipesCell.self, forCellWithReuseIdentifier: String(describing: RecentRecipesCell.self))
        collectionView.register(RecentRecipesCell.self, forCellWithReuseIdentifier: String(describing: RecentRecipesCell.self))
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    static func createLoadingView() -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
        
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        
        return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
            switch sectionType {
                
            case .trendingNow:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeeAllRecipesCell.self), for: indexPath) as! SeeAllRecipesCell
                if let recipeViewModel = item as? RecipesCellViewModel {
                    cell.update(with: recipeViewModel, didSelectHandler: recipeViewModel.didSelect)
                }
                return cell
            case .trendigHeader, .popularCategoryHeader, .countryHeader, .recentRecipeHeader:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderRecipesCell.self), for: indexPath) as! HeaderRecipesCell
                if let seeAllViewModel = item as? SeeAll {
                    cell.update(with: seeAllViewModel, didSelectHandler: nil)
                }
                return cell
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
                if let item = item as? Category {
                    cell.update(with: item, didSelectHandler: item.didSelect)
                }
                return cell
            case .circeRecipe:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CircleRecipesCell.self), for: indexPath) as! CircleRecipesCell
                if let item = item as? RecipesCellViewModel {
                    cell.update(with: item, didSelectHandler: item.didSelect)
                }
                return cell
            case .recentRecipe:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecentRecipesCell.self), for: indexPath) as! RecentRecipesCell
                if let item = item as? RecipesCellViewModel {
                    cell.update(with: item, didSelectHandler: item.didSelect)
                }
                return cell
            case .country:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CountryCell.self), for: indexPath) as! CountryCell
                if let item = item as? Country {
                    cell.update(with: item, didSelectHandler: item.didSelect)
                }
                return cell
            }
        }
    }
}

//MARK: - Create and Composional layout
private extension HomeControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        .init { [weak self] sectionIndex, _ in
            guard
                let sectionType = Section(rawValue: sectionIndex),
                let self = self else {
                return nil
            }
            
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
            case .recentRecipeHeader:
                return self.headerSetion()
            case .recentRecipe:
                return self.createRecentRecipeLayout()
            case .countryHeader:
                return self.headerSetion()
            case .country:
                return self.createCountryLayout()
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .fractionalHeight(0.05)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5)
        
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
            widthDimension: .fractionalWidth(0.433),
            heightDimension: .fractionalHeight(0.287)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func createRecentRecipeLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.39),
            heightDimension: .fractionalHeight(0.26)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func createCountryLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.18)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
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
        case recentRecipeHeader
        case recentRecipe
        case countryHeader
        case country
    }
}

extension HomeControllerImpl:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .categories:
            let indexPath = IndexPath(item: 0, section: Section.circeRecipe.rawValue)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        default:
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        if let previousIndexPath = selectedIndexPaths[section.rawValue], previousIndexPath != indexPath {
            collectionView.deselectItem(at: previousIndexPath, animated: false)
            selectedIndexPaths[section.rawValue] = indexPath
        } else if let previousIndexPath = selectedIndexPaths[section.rawValue], previousIndexPath == indexPath {
            return
        } else {
            selectedIndexPaths[section.rawValue] = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {  return true }
        switch section {
        case .categories:
            return indexPath != selectedIndexPaths[indexPath.section]
        default: return true
        }
    }
}


@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ModuleFactory().createHomeModule(searchController: HomeCoordinator(ModuleFactory()).createSearchModule(), flowHandler: nil))
}
