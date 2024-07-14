//
//  BookmarkViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit

import UIKit
import SnapKit

typealias BookmarkRecipesCell = CollectionCell<BookmarkView>

final class BookmarkControllerImpl: UIViewController {
    
    var presenter: (any BookmarkPresenter)?
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
}

//MARK: - class BookmarkController implement
extension BookmarkControllerImpl: BookmarkController {
    func update(with model: BookmarkViewModel?) {
        updateCollection(with: model!)
    }
}


private extension BookmarkControllerImpl {
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
    
    func updateCollection(with model: BookmarkViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.favoriteRecipe])
        snapshot.appendItems(model.favoriteRecipes, toSection: .favoriteRecipe)
        print(model.favoriteRecipes)
//        dataSource.apply(snapshot, animatingDifferences: true)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

//MARK: - Create and Configure Properties
private extension BookmarkControllerImpl {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(BookmarkRecipesCell.self, forCellWithReuseIdentifier: String(describing: BookmarkRecipesCell.self))
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
            switch sectionType {
            case .favoriteRecipe:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BookmarkRecipesCell.self), for: indexPath) as! BookmarkRecipesCell
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
private extension BookmarkControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout.init { sectionIndex, _ in
            let sectionType = Section(rawValue: sectionIndex)!
            switch sectionType {
            case .favoriteRecipe:
                return self.favoriteRecipeSection()
            }
        }
        layout.configuration = config
        return layout
    }
    
    func favoriteRecipeSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(282.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

private extension BookmarkControllerImpl {
    private enum Section: Int, CaseIterable {
        case favoriteRecipe
    }
}

extension BookmarkControllerImpl:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath)
    }
}
