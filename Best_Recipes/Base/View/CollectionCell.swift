//
//  CollectionView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//
import SnapKit
import UIKit

class CollectionCell<View: Configurable & UIView >: UICollectionViewCell {
    private let view = View()
    private let stackView = UIStackView()
    private var didSelectHandler: (() -> Void)?
    
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
        backgroundColor = .clear
    }
    
    func update(
        with model: View.Model,
        height: CGFloat? = nil,
        insets: UIEdgeInsets = .zero,
        didSelectHandler: (() -> Void)? = nil
    ) {
        view.update(with: model)
        self.didSelectHandler = didSelectHandler
//        
//        if let height {
//            stackView.snp.remakeConstraints {
//                $0.height.equalTo(height)
//                $0.edges.equalToSuperview().inset(insets)
//            }
//        } else {
//            stackView.snp.updateConstraints {
//                $0.edges.equalToSuperview().inset(insets)
//            }
//        }
    
    }
    
    private func configure() {
        
        backgroundColor = .clear
        
//        contentView.addSubview(stackView)
//        stackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        stackView.addArrangedSubview(view)
        contentView.addSubview(view)
        view.snp.makeConstraints {
                   $0.edges.equalToSuperview()
               }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tapGR.cancelsTouchesInView = false
        addGestureRecognizer(tapGR)
    }
    
    @objc
    private func didSelect() {
        didSelectHandler?()
    }
}
