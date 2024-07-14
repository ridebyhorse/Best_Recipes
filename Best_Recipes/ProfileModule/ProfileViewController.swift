//
//  ProfileViewController.swift
//  Best_Recipes
//
//  Created by Дмитрий Волков on 30.06.2024.
//


import UIKit
import SnapKit


// MARK: - UIViewController
class ProfileViewController: UIViewController {
 
    var favRecipes: [Recipe]?
    
    var userImage: UIImageView!
    var subheadingLabel: UILabel!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        favRecipes = StorageService.shared.getCreatedRecipes() // Get data
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        userImage = UIImageView()
        userImage.image = UIImage(named: "AppIcon") // ПОМЕНЯТЬ ИЗОБРАЖЕНИЕ ПОЛЬЗОВАТЕЛЯ
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = 100
        userImage.clipsToBounds = true
        
        subheadingLabel = UILabel()
        subheadingLabel.text = "My recipes"
        subheadingLabel.font = .custom(font: .bold, size: 24)
        subheadingLabel.textColor = .black
        
        view.addSubview(userImage)
        view.addSubview(subheadingLabel)
        view.addSubview(collectionView)
        
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        subheadingLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(30)
            make.left.right.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(subheadingLabel.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "favouriteRecipeCell")
        
       }
    
    private func handlePhotoURL(image: URL?) -> UIImage {
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        if let url = image?.lastPathComponent {
            let assetURL = bundleURL.appendingPathComponent(url) // Bundle URL
            do {
              let contents = try fileManager.contentsOfDirectory(at: assetURL,
             includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey],
             options: .skipsHiddenFiles)
              for item in contents { // item is the URL of everything in MyBundle imgs or otherwise.

                  let imageRet = UIImage(contentsOfFile: item.path) // Initializing an image
                  return imageRet! // Adding the image to the icons array
              }
            }
            catch let error as NSError {
              print(error)
                return UIImage(named: "AppIcon")!
            }
        }
        return UIImage(named: "Onboarding1")!
    }
    private func bestMetadataCollectionMethod(with url: URL) -> CFDictionary? {
        let options = [kCGImageSourceShouldCache as String: kCFBooleanFalse]
        guard let data = NSData(contentsOf: url) else { return nil }
        guard let imgSrc = CGImageSourceCreateWithData(data, options as CFDictionary) else {
            return nil }
        let metadata = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options as CFDictionary)
        return metadata
    }
}
    
 
// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favRecipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteRecipeCell", for: indexPath) as! RecipeCell
        let image: UIImage = handlePhotoURL(image: favRecipes?[indexPath.row].image ?? URL(string: ""))  // ПОМЕНЯТЬ ИЗОБРАЖЕНИЕ БЛЮДА
        cell.recipeImageView.image = image
        cell.ratingLabel.text = String(format: "%.1f", favRecipes?[indexPath.row].rating ?? 0 / 20.0)
        cell.titleLabel.text = favRecipes?[indexPath.row].title ?? "My Recipe"
        cell.ingridientsLabel.text = String(favRecipes?[indexPath.row].ingredients?.count ?? 0) + " ingredients"
        cell.cookTimeLabel.text = cell.calculateCookTime(mins: favRecipes?[indexPath.row].cookingTime ?? 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 250)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Custom Cell
class RecipeCell: UICollectionViewCell {
     let recipeImageView = UIImageView()
     let ratingView = UIView()
     let starImage = UIImageView()
     let ratingLabel = UILabel()
     let titleLabel = UILabel()
     let ingridientsLabel = UILabel()
     let separator =  UIView()
     let cookTimeLabel = UILabel()
 
     override init(frame: CGRect) {
         super.init(frame: frame)
         addSubviews(recipeImageView, ratingView, titleLabel, ingridientsLabel, separator, cookTimeLabel)
         ratingView.addSubviews(starImage, ratingLabel)
         
         recipeImageView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
         ratingView.snp.makeConstraints { make in
             make.top.leading.equalToSuperview().inset(8)
             make.width.equalTo(58)
             make.height.equalTo(28)
         }
         starImage.snp.makeConstraints { make in
             make.height.width.equalTo(18)
             make.leading.equalToSuperview().inset(8)
             make.centerY.equalToSuperview()
         }
         ratingLabel.snp.makeConstraints { make in
             make.trailing.equalToSuperview().inset(8)
             make.centerY.equalToSuperview()
         }
         titleLabel.snp.makeConstraints { make in
             make.bottom.equalToSuperview().inset(36)
             make.leading.equalToSuperview().inset(15)
             make.trailing.equalToSuperview().inset(17)
         }
         ingridientsLabel.snp.makeConstraints { make in
             make.bottom.equalToSuperview().inset(16)
             make.leading.equalToSuperview().inset(15)
         }
         
         separator.snp.makeConstraints { make in
             make.width.equalTo(1)
             make.height.equalTo(18)
             make.centerY.equalTo(ingridientsLabel)
             make.leading.equalTo(ingridientsLabel.snp.trailing).offset(7)
         }
         
         cookTimeLabel.snp.makeConstraints { make in
             make.bottom.equalTo(ingridientsLabel)
             make.leading.equalTo(separator.snp.trailing).offset(7)
         }
         
         recipeImageView.layer.cornerRadius = 20
         recipeImageView.layer.masksToBounds = true
         
         ratingView.backgroundColor = UIColor(named: "darkGreyApp")
         ratingView.layer.cornerRadius = 8
         ratingView.clipsToBounds = true
         
         starImage.image = UIImage(imageLiteralResourceName: "Star")
         starImage.contentMode = .scaleAspectFit
         
         ratingLabel.font = .custom(font: .bold, size: 14)
         ratingLabel.textColor = .white
         
         titleLabel.font = .custom(font: .bold, size: 20)
         titleLabel.textColor = .white
         titleLabel.numberOfLines = 0
         
         ingridientsLabel.font = .custom(font: .regular, size: 12)
         ingridientsLabel.textColor = .white
         
         separator.backgroundColor = .white
         
         cookTimeLabel.font = .custom(font: .regular, size: 12)
         cookTimeLabel.textColor = .white
         
         
     }
 
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func calculateCookTime(mins: Int) -> String {
         let hours = mins / 60
         let minutes = mins % 60
         if hours > 0 {
             return "\(hours) h \(minutes) min"
         } else {
             return "\(minutes) min"
         }
     }
    
    
}
