//
//  ReusableView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit

final class CollectionReusableView<View: Configurable & CellView>: UICollectionReusableView {
    private let view = View()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.update(with: nil)
    }
    
    func update(with model: View.Model, insets: UIEdgeInsets = .zero) {
        view.update(with: model)
        view.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
    
    private func configure() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
