////
////  RecipeButton.swift
////  CreateRecipe
////
////  Created by Сергей Сухарев on 06.07.2024.
////
//
//import UIKit
//
//class RecipeButton: UIButton {
//
//        var leftImage: UIImage?
//        var rightImage: UIImage?
//    
//    override init(frame:CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private func setup() {
//        
//        setTitleColor(.black, for: .normal)
//        backgroundColor = UIColor(named: "lightGreyApp")
//        layer.cornerRadius = 8
//        //setImage(UIImage(named: "Clock"), for: .normal)
//        translatesAutoresizingMaskIntoConstraints = false
//        //contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 200)
////        if let leftImage = leftImage {
////            let leftImageView = UIImageView(image: leftImage)
////            leftImageView.contentMode = .scaleAspectFit
////            addSubview(leftImageView)
//            //leftImageView.translatesAutoresizingMaskIntoConstraints = false
////            setImage(leftImage, for: .normal)
////            setImage(rightImage, for: .normal)
////        rightImage.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
////            NSLayoutConstraint.activate([
////                leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
////                leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
////                leftImageView.widthAnchor.constraint(equalToConstant: 20),
////                leftImageView.heightAnchor.constraint(equalToConstant: 20)
////            ])
////        }
////        if let rightImage = rightImage {
////            let rightImageView = UIImageView(image: rightImage)
////            rightImageView.contentMode = .scaleAspectFit
////            addSubview(rightImageView)
////            rightImageView.translatesAutoresizingMaskIntoConstraints = false
////            
////            NSLayoutConstraint.activate([
////                rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
////                rightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
////                rightImageView.widthAnchor.constraint(equalToConstant: 20),
////                rightImageView.heightAnchor.constraint(equalToConstant: 20)
////            ])
////        }
//    }
//    func setButtonTitle(title: String) {
//         setTitle(title, for: .normal)
//     }
//   
//}
