//
//  CreateRecipeViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit
import Photos
import MobileCoreServices

class CreateRecipeViewController: UIViewController {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName:  "questionmark")
        imageView.tintColor = UIColor(named: "redApp")
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private func createButtons() {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "Edit"), for: .normal)
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        mainStackView.addSubviews(button)
        button.backgroundColor = .systemGray
    }
    @objc private func buttonsTapped(_ sender: UIButton) {
        print("hel")
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.mediaTypes = ["public.image"]
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    private var chooseImageButton = ChooseImageButton()
    
    let createRecipeButton = CreateRecipeButton()
    let cookTimeButton = RecipeButton()
    let servesButton = RecipeButton()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            PHPhotoLibrary.authorizationStatus()
            PHPhotoLibrary.requestAuthorization { _ in }
                
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            
//            navigationController?.navigationBar.tintColor = .black
             view.backgroundColor = .white
//
//            navigationItem.title = "Create recipe"
//            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButton))
    //        setupNameRecipe()
    //        setupInstruction()
            
            
            cookTimeButton.leftImage = UIImage(named: "Clock")
            cookTimeButton.rightImage = UIImage(named: "Clock")
            cookTimeButton.setButtonTitle(title: "Cook Time")
            servesButton.setButtonTitle(title: "Serves")
            setViews()
            setupConstraints()
            setupCreateRecipeButton()
            //setupRecipeButton()
            createButtons()
        }
        
//        @objc private func backButton() {
//            print("назад")
//        }
        
//        private lazy var titleStackView: UIStackView = {
//            let element = UIStackView()
//            element.backgroundColor = .white
//            element.spacing = 0
//            element.distribution = .fillEqually
//            element.axis = .vertical
//            element.translatesAutoresizingMaskIntoConstraints = false
//            return element
//        }()
        
        private lazy var mainStackView: UIStackView = {
            let element = UIStackView()
            element.backgroundColor = .white
            element.spacing = 16
            element.distribution = .fillEqually
            element.axis = .vertical
            element.alignment = .fill
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let nameRecipe = UITextField(text: "    Название рецепта",size: 24, weight: .bold)
        let instructions = UITextField(text: "   Инструкция по приготовлению", size: 16, weight: .regular)
        
        private func setupCreateRecipeButton() {
            view.addSubview(createRecipeButton)
            NSLayoutConstraint.activate([
                createRecipeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                createRecipeButton.heightAnchor.constraint(equalToConstant: 56),
                createRecipeButton.widthAnchor.constraint(equalToConstant: 343)
            ])
        }
     
    //    private func setupNameRecipe() {
    //        view.addSubview(nameRecipe)
    //        NSLayoutConstraint.activate([
    //            nameRecipe.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
    //            nameRecipe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
    //            nameRecipe.heightAnchor.constraint(equalToConstant: 44),
    //            nameRecipe.widthAnchor.constraint(equalToConstant: 343)
    //        ])
    //    }
    //    private func setupInstruction() {
    //        view.addSubview(instructions)
    //        NSLayoutConstraint.activate([
    //            instructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
    //            instructions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 268),
    //            instructions.heightAnchor.constraint(equalToConstant: 44),
    //            instructions.widthAnchor.constraint(equalToConstant: 343)
    //        ])
            
      //  }
        private func setupConstraints() {
            NSLayoutConstraint.activate([
    //            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
                
                
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                mainStackView.heightAnchor.constraint(equalToConstant: 425),
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
//                nameRecipe.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
//                nameRecipe.topAnchor.constraint(equalTo: mainStackView.topAnchor),
//                nameRecipe.heightAnchor.constraint(equalToConstant: 44),
//                nameRecipe.widthAnchor.constraint(equalToConstant: 343),
//                
//                //imageView.topAnchor.constraint(equalTo: nameRecipe.topAnchor, constant: 16),
////                imageView.heightAnchor.constraint(equalToConstant: 77),
////                imageView.widthAnchor.constraint(equalToConstant: 343),
//                
//                
//                //instructions.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
//                instructions.heightAnchor.constraint(equalToConstant: 44),
//                instructions.widthAnchor.constraint(equalToConstant: 343)
                
                
            ])
        }
    private func setupRecipeButton() {
//        mainStackView.addSubview(cookTimeButton)
//        mainStackView.addSubviews(servesButton)
//        
        NSLayoutConstraint.activate([
//                servesButton.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
//                servesButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -92),
            servesButton.heightAnchor.constraint(equalToConstant: 60),
            servesButton.widthAnchor.constraint(equalToConstant: 343),
            
//                cookTimeButton.centerXAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.centerXAnchor),
            cookTimeButton.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 434),
            cookTimeButton.heightAnchor.constraint(equalToConstant: 60),
            cookTimeButton.widthAnchor.constraint(equalToConstant: 343)
            
        ])
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            imageView.image = selectedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
}
    extension CreateRecipeViewController {
        private func setViews() {
            view.addSubview(mainStackView)
            mainStackView.addArrangedSubview(nameRecipe)
            mainStackView.addArrangedSubview(imageView)
            //mainStackView.addArrangedSubview(chooseImageButton)
            mainStackView.addArrangedSubview(instructions)
            mainStackView.addArrangedSubview(cookTimeButton)
            mainStackView.addArrangedSubviews(servesButton)
        }
    }
    extension UITextField{
        convenience init(text: String, size: CGFloat , weight: UIFont.Weight ) {
            self.init()
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: size, weight: weight)])
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor(named: "redApp")?.cgColor
            self.layer.cornerRadius = 8
            self.keyboardType = .default
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
extension CreateRecipeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.mediaType] as? String == "public.image" {
            self.handlePhoto(info)
        } else {
            print("DEBUG PRINT:", "Media was neither image")
            
        }
        
//        DispatchQueue.main.async { [weak self] in
//            self?.dismiss(animated: true, completion: nil)
//        }
    }
    //MARK: - Images
    private func handlePhoto(_ info: [UIImagePickerController.InfoKey: Any]) {
        
        if let imageURL = info[.imageURL] as? URL {
            print("DEBUG PRINT:", "Image URL: \(imageURL.description)")
            
            let dict: CFDictionary? = self.bestMetadataCollectionMethod(with: imageURL )
            print("DEBUG PRINT:", dict ?? "Failed to get metadata")
        }
        
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
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

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CustomTabBarController())
}
