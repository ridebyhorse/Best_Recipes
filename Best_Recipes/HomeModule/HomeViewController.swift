//
//  HomeController.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit
import SwiftUI

//MARK: - class HomeControllerImpl
final class HomeControllerImpl: UIViewController {
    
    //MARK: - Presenter
    var presenter: (any HomePresenter)?
    private var sections = [Sections]()
    
    //MARK: - Private properties
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
       
    }
}

//MARK: - class HomeController implement
extension HomeControllerImpl: HomeController {
    
    func update(with model: HomeViewModel?) {
        sections.append(.trendingNow(model: model!.tandingNow.resepies, header: model!))
        collectionView.reloadData()
    }
}


private extension HomeControllerImpl {
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
    
}

//MARK: - Create and Configure any Views
private extension HomeControllerImpl {
     func createCollectionView() -> UICollectionView {
         let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
         collectionView.register(BannerRecipesCell.self, forCellWithReuseIdentifier: String(describing: BannerRecipesCell.self))
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
}

//MARK: - Create and Composional layout
private extension HomeControllerImpl {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
           .init { [unowned self] sectionIndex, _ in
               let sectionType = self.sections[sectionIndex]
               switch sectionType {
                   
               case .trendingNow:
                   return self.createTrendingNowSection()
               }
           }
       }
       
       func createTrendingNowSection() -> NSCollectionLayoutSection {
           
           let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(280),
            heightDimension: .absolute(254)
           )
           
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
           
           let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(1),
            heightDimension: .absolute(254)
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
    private enum Sections {
        case trendingNow(model: [RecipesCellViewModel], header: HomeViewModel)
    }
}

typealias BannerRecipesCell = CollectionCell<BannerRecipesView>



extension HomeControllerImpl:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .trendingNow(model: let model, header: let header):
            return model.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .trendingNow(model: let model, header: let header):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerRecipesCell.self), for: indexPath) as! BannerRecipesCell
            cell.update(with: model[indexPath.row], didSelectHandler: model[indexPath.row].didSelect)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}



