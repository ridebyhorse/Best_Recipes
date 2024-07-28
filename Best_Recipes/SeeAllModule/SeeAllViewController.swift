//
//  SeeAllViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import UIKit
import SnapKit

typealias SeeAllCountryCell = CollectionCell<SeeAllCountryView>
typealias SeeAllRecipesCell = CollectionCell<SeeAllView>

//MARK: - class SeeAllControllerImpl
final class SeeAllControllerImpl: UIViewController {
    
    //MARK: - Presenter
    var presenter: (any SeeAllPresenter)?
    
    //MARK: - Private properties
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    private var selectedIndexPath = IndexPath(row: 0, section: 0) 
//    {
//        didSet {
//            if oldValue != selectedIndexPath {
//                collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [.centeredVertically])
//                print(selectedIndexPath)
//                print(oldValue)
//            }
//        }
//    }
    private var model: SeeAllViewModel?
    private var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }
}

//MARK: - class SeeAllController implement
extension SeeAllControllerImpl: SeeAllController {
    
    func update(with model: SeeAllViewModel?) {
        self.model = model
        updateCollection(with: model!)
        if firstLoad && model!.mode == .countries {
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
            firstLoad = false
        } 
//        else if !firstLoad && model!.mode == .countries {
//            let countries = model!.countries.map({$0.headerName})
//            if let index = countries.firstIndex(of: presenter?.country! ?? "") {
//                collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: [])
//            }
//            collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
//        }
    }
}

private extension SeeAllControllerImpl {
    func configure() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubviews(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func updateCollection(with model: SeeAllViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.countries, .recipes])
        snapshot.appendItems(model.countries, toSection: .countries)
        snapshot.appendItems(model.recipes, toSection: .recipes)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

//MARK: - Create and Configure Properties
private extension SeeAllControllerImpl {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(SeeAllCountryCell.self, forCellWithReuseIdentifier: String(describing: SeeAllCountryCell.self))
        collectionView.register(SeeAllRecipesCell.self, forCellWithReuseIdentifier: String(describing: SeeAllRecipesCell.self))
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
            switch sectionType {
            case .countries:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeeAllCountryCell.self), for: indexPath) as! SeeAllCountryCell
                if let item = item as? SeeAllCountry {
                    cell.update(with: item, didSelectHandler:  { [weak self] in
                        if let select = item.didSelect {
                            select()
                        }
                        self?.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    })
                }
                return cell
            case .recipes:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeeAllRecipesCell.self), for: indexPath) as! SeeAllRecipesCell
                if let item = item as? RecipesCellViewModel {
                    cell.update(with: item, didSelectHandler: item.didSelect)
                }
                return cell
            }
        }
    }
    
}

//MARK: - Create and Composional layout
private extension SeeAllControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        .init { [weak self] sectionIndex, _ in
            guard
                let sectionType = Section(rawValue: sectionIndex),
                let self = self else {
                return nil
            }
                
            switch sectionType {
            case .countries:
                return self.createCountrySection()
            case .recipes:
                return self.createRecipeLayout()
            }
        }
    }
    
    func createCountrySection() -> NSCollectionLayoutSection {
        
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
    
    func createRecipeLayout() -> NSCollectionLayoutSection {
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

private extension SeeAllControllerImpl {
    private enum Section: Int, CaseIterable {
        case countries
        case recipes
    }
}

extension SeeAllControllerImpl:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .countries:
            selectedIndexPath = indexPath
        default:
            collectionView.deselectItem(at: indexPath, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {  return true }
        switch section {
        case .countries:
            return false
        default: return true
        }
    }
}

