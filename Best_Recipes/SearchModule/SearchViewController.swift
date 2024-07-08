//
//  SearchViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 06.07.2024.
//

import UIKit
import SnapKit

typealias SearchRecipesCell = CollectionCell<SearchRecipesView>

final class SearchControllerImpl: UIViewController {
    
    var presenter: (any SearchPresenter)?
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
}

//MARK: - class SearchController implement
extension SearchControllerImpl: SearchController {
    func update(with model: SearchViewModel?) {
        updateCollection(with: model!)
    }
}


private extension SearchControllerImpl {
    func configure() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubviews(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateCollection(with model: SearchViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.searchedRecipe])
        snapshot.appendItems(model.searchedRecipes, toSection: .searchedRecipe)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
}

//MARK: - Create and Configure Properties
private extension SearchControllerImpl {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(SearchRecipesCell.self, forCellWithReuseIdentifier: String(describing: SearchRecipesCell.self))
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
            switch sectionType {
            case .searchedRecipe:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchRecipesCell.self), for: indexPath) as! SearchRecipesCell
                print(item)
                if let recipeViewModel = item as? RecipesCellViewModel {
                    cell.update(with: recipeViewModel, didSelectHandler: recipeViewModel.didSelect)
                }
                return cell
            }
        }
    }
}

//MARK: - Create and Composional layout
private extension SearchControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout.init { sectionIndex, _ in
            let sectionType = Section(rawValue: sectionIndex)!
            switch sectionType {
            case .searchedRecipe:
                return self.searchedRecipeSection()
            }
        }
        layout.configuration = config
        return layout
    }
    
    func searchedRecipeSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

private extension SearchControllerImpl {
    private enum Section: Int, CaseIterable {
        case searchedRecipe
    }
}

extension SearchControllerImpl:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

@available(iOS 17.0, *)
#Preview {
    Builder.createSearchScreen()
}
