//
//  SearchBar.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 05.07.2024.
//

import UIKit

final class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImages()
        setUpSearchTextField()
        setUpAppearence()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setShowsCancelButton(false, animated: false)
        if isFirstResponder {
            searchTextField.layer.borderColor = UIColor.redApp.cgColor
        } else {
            searchTextField.layer.borderColor = UIColor.greyApp.cgColor
        }
        super.layoutSubviews()
    }
    
    private func setUpSearchTextField() {
        searchTextField.font = .custom(font: .regular, size: 13)
        searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        searchTextField.textColor = .black
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.borderWidth = 1.0
        searchTextField.backgroundColor = .white
        searchTextField.clearButtonMode = .always
        let attributedPlaceholder = NSAttributedString(string: "Search recipes", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        searchTextField.attributedPlaceholder = attributedPlaceholder
        
    }
    
    private func setUpImages(){
        let searchImage = UIImage(imageLiteralResourceName: "Search")
        let clearImage = UIImage(imageLiteralResourceName: "Close")
        setImage(searchImage, for: .search, state: .normal)
        setImage(clearImage, for: .clear, state: .normal)
    }
    
    private func setUpAppearence() {
        let backgroundImage = UIImage.imageWithColor(color: .white)
        setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        layer.borderWidth = 0
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}

class CustomSearchController: UISearchController {
    
    private var customSearchBar = SearchBar()
    
    override public var searchBar: UISearchBar {
        get {
            return customSearchBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {

             clearButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        }
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
}

extension UIImage {
    static func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 20, height: 44)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
