//
//  IngredientsTableView.swift
//  Best_Recipes
//
//  Created by Natalia on 02.07.2024.
//

import UIKit

final class IngredientsTableView: UITableView {
    
    var items: [IngredientViewModel]?
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .custom(font: .bold, size: 20)
        return label
    }()
    
    private let ingredientsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreyApp
        label.font = .custom(font: .regular, size: 14)
        return label
    }()
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getHeader() -> UIView {
        let headerView = UIView()
        headerView.addSubview(ingredientsLabel)
        headerView.addSubview(ingredientsCountLabel)
        
        ingredientsLabel.snp.makeConstraints { $0.centerY.leading.equalToSuperview() }
        ingredientsCountLabel.snp.makeConstraints { $0.centerY.equalToSuperview() }
        ingredientsCountLabel.snp.makeConstraints { $0.trailing.equalToSuperview().inset(7) }
        return headerView
    }
}


extension IngredientsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemsCount = tableView.numberOfRows(inSection: .zero)
        ingredientsCountLabel.text = "\(itemsCount) items"
        let header = getHeader()
        return header
    }
}

extension IngredientsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: IngredientCell.identifier,
                for: indexPath
            )
                as? IngredientCell
        else { fatalError("configure IngredientCell fail") }

        if let item = items?[indexPath.row] {
            cell.configureCell(
                ingredintName: item.title,
                amount: item.amountAndUnit,
                image: item.image!,
                isSelected: item.isAvailable,
                isAvailableTap: item.availableHandler
            )
        }
        return cell
    }
}


