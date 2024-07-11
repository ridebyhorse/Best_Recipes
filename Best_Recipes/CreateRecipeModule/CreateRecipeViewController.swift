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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //        scrollView.backgroundColor = .white
        //        scrollView.frame = view.bounds
        scrollView.contentSize = contenSize
        //        scrollView.contentInset = UIEdgeInsets(top: contentView.frame.height, left: 0, bottom: 0, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        
        let contentView = UIView()
        //        contentView.backgroundColor = .white
        contentView.frame.size = contenSize
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        //        stackView.backgroundColor = .green
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var contenSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 900)
    }
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "addRecipeImage")
        imageView.tintColor = UIColor(named: "redApp")
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func createButtons() {
        var button = ChooseImageButton()
        button.onTap = { [weak self] in
            self?.buttonsTapped()
        }
        
        view.addSubviews(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            button.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: 32),
            button.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func buttonsTapped() {
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
    
    private let cookTimeLabel = UILabel()
    private func setCookTimeLabel() {
        cookTimeLabel.text = "                Cook time"
        cookTimeLabel.textColor = .black
        cookTimeLabel.textAlignment = .left
        cookTimeLabel.font = .boldSystemFont(ofSize: 16)
        cookTimeLabel.backgroundColor = UIColor(named: "lightGreyApp")
        cookTimeLabel.layer.masksToBounds = true
        cookTimeLabel.layer.cornerRadius = 12
        cookTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private let cookTimeImage = UIImageView()
    private func setCookTimeImage() {
        cookTimeImage.image = UIImage(named: "Icon - Serves-2")
        cookTimeImage.contentMode = .scaleAspectFit
        cookTimeImage.backgroundColor = .white
        cookTimeImage.layer.cornerRadius = 12
        //        Icon - Serves-2
        //cookTimeImage.
        cookTimeImage.clipsToBounds = true
        cookTimeImage.isUserInteractionEnabled = true
        cookTimeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            cookTimeImage.topAnchor.constraint(equalTo: cookTimeLabel.topAnchor),
            cookTimeImage.leftAnchor.constraint(equalTo: cookTimeLabel.leftAnchor, constant: 16),
            cookTimeImage.centerYAnchor.constraint(equalTo: cookTimeLabel.centerYAnchor),
            //            cookTimeImage.widthAnchor.constraint(equalTo: servesImage.widthAnchor),
            //            cookTimeImage.heightAnchor.constraint(equalTo: servesImage.heightAnchor),
            //            cookTimeImage.heightAnchor.constraint(equalToConstant: 32),
            //            cookTimeImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    private func setServesImage() {
        servesImage.image = UIImage(named: "Icon - Serves")
        servesImage.contentMode = .scaleAspectFit
        //cookTimeImage.backgroundColor = .white
        //cookTimeImage.layer.cornerRadius = 12
        servesImage.isUserInteractionEnabled = true
        servesImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            cookTimeImage.topAnchor.constraint(equalTo: cookTimeLabel.topAnchor),
            servesImage.leftAnchor.constraint(equalTo: servesLabel.leftAnchor, constant: 16),
            servesImage.centerYAnchor.constraint(equalTo: servesLabel.centerYAnchor),
            //            cookTimeImage.heightAnchor.constraint(equalToConstant: 32),
            //            cookTimeImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //        if textView.textColor == UIColor.lightGray {
    //            textView.text = nil
    //            textView.textColor = UIColor.black
    //        }
    //
    //    }
    
    
    private let servesLabel = UILabel()
    private func setServesLabel() {
        servesLabel.text = "                Serves"
        servesLabel.textColor = .black
        servesLabel.textAlignment = .left
        servesLabel.font = .boldSystemFont(ofSize: 16)
        servesLabel.backgroundColor = UIColor(named: "lightGreyApp")
        servesLabel.layer.masksToBounds = true
        servesLabel.layer.cornerRadius = 12
        servesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let servesImage = UIImageView()
    
    private let ingredientsTitle = UILabel()
    
    private func setIngredientsTitle() {
        ingredientsTitle.text = "Ingredients"
        ingredientsTitle.textColor = .black
        ingredientsTitle.textAlignment = .left
        ingredientsTitle.font = .boldSystemFont(ofSize: 20)
        ingredientsTitle.backgroundColor = .white
        ingredientsTitle.layer.masksToBounds = true
        ingredientsTitle.layer.cornerRadius = 12
        ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let addIngredientsButton = UIButton()
    private func  setAddIngredientsButton() {
        addIngredientsButton.tintColor = .black
        addIngredientsButton.backgroundColor = .white
        addIngredientsButton.setImage(UIImage(named: "Plus-Border"), for: .normal)
        addIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        addIngredientsButton.addTarget(self, action: #selector(buttonTappedAdd), for: .touchUpInside)
    }
    
    @objc private func buttonTappedAdd(sender: UIButton) {
        print("tap")
        if sender.currentImage == UIImage(named: "Plus-Border") {
            sender.setImage(UIImage(named: "Minus-Border"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "Plus-Border"), for: .normal)
        }
    }
    
    
    
    let createRecipeButton = CreateRecipeButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameRecipe.delegate = self
        instructions.delegate = self
        
        PHPhotoLibrary.authorizationStatus()
        PHPhotoLibrary.requestAuthorization { _ in }
        
        view.backgroundColor = .white
        
        setViews()
        setupConstraints()
        createButtons()
        setServesImage()
        setCookTimeImage()
        setCookTimeLabel()
        setServesLabel()
        setIngredientsTitle()
        setAddIngredientsButton()
        setPlaceholderNameRecipe()
        setPlaceholderInstruction()
    }
    
    let nameRecipe = UITextView(size: 24,numb: 4, weight: .bold)
    
    let placeholderNameRecipe = UILabel()
    private func setPlaceholderNameRecipe() {
        //placeholderNameRecipe.delegate = self
        placeholderNameRecipe.text = "Название рецепта"
        placeholderNameRecipe.textColor = .lightGray
        placeholderNameRecipe.textAlignment = .center
        placeholderNameRecipe.font = .boldSystemFont(ofSize: 16)
        //placeholderNameRecipe.backgroundColor = UIColor(named: "lightGreyApp")
        //placeholderNameRecipe.layer.masksToBounds = true
        //placeholderNameRecipe.layer.cornerRadius = 12
//        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
        //placeholderNameRecipe.isHidden = true
        placeholderNameRecipe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderNameRecipe.leadingAnchor.constraint(equalTo: nameRecipe.leadingAnchor, constant: 15),
            placeholderNameRecipe.topAnchor.constraint(equalTo: nameRecipe.topAnchor),
            placeholderNameRecipe.centerYAnchor.constraint(equalTo: nameRecipe.centerYAnchor)
            
        ])
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            placeholderNameRecipe.isHidden = true
//        }
        ////        placeholderNameRecipe.frame.origin = CGPoint(x: nameRecipe.frame.origin.x + 10,
        //                                                     y: nameRecipe.frame.midY - placeholderNameRecipe.frame.size.height / 2)
        
    }
    
    
    
    let instructions = UITextView(size: 16,numb: 0, weight: .regular)
    let placeholderInstruction = UILabel()
    //instructions.delegate = self
    private func setPlaceholderInstruction() {
        placeholderInstruction.text = "Инструкция приготовения"
        placeholderInstruction.textColor = .lightGray
        placeholderInstruction.textAlignment = .center
        placeholderInstruction.font = .boldSystemFont(ofSize: 16)
        //placeholderNameRecipe.backgroundColor = UIColor(named: "lightGreyApp")
        //placeholderNameRecipe.layer.masksToBounds = true
        //placeholderNameRecipe.layer.cornerRadius = 12
        //placeholderInstruction.isHidden = !nameRecipe.text.isEmpty
        placeholderInstruction.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderInstruction.leadingAnchor.constraint(equalTo: nameRecipe.leadingAnchor, constant: 15),
            placeholderInstruction.topAnchor.constraint(equalTo: instructions.topAnchor),
            placeholderInstruction.centerYAnchor.constraint(equalTo: instructions.centerYAnchor)
        ])
    }
    
    
    let addIngredientsName = UITextField(text: "   Item name", size: 14, weight: .regular, borderColor: UIColor(named: "ColorBorder")!)
    let addQuantityIngredients = UITextField(text: "   Quantity", size: 14, weight: .regular, borderColor: UIColor(named: "ColorBorder")!)
    
//    func saveRecipe() {
//        var recipe = Recipe(rating: 100, id: 123456, title: nameRecipe.text, countries: [], categories: [], cookingTime: <#T##Int#>, isTrending: false, reviewsCount: 0, author: <#T##String#>, ingredients: [Ingridient(originalName: addIngredientsName.text!, amount: <#T##Double#>, unit: <#T##String#>)], instructions: [Instruction(steps: [InstructionStep(number: 1, step: instructions.text!)), image: nil)
//    }
    
    
    private func setupConstraints() {
        //            let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        //                heightConstraint.priority = UILayoutPriority(250)
        
        
        instructions.delegate = self
        NSLayoutConstraint.activate([
            createRecipeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 56),
            createRecipeButton.widthAnchor.constraint(equalToConstant: 343),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //                contentView.heightAnchor.constraint(equalToConstant: 900),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            //                heightConstraint,
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor, constant: -16),
            
            nameRecipe.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameRecipe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            nameRecipe.heightAnchor.constraint(equalToConstant: 44),
            nameRecipe.widthAnchor.constraint(equalToConstant: 343),
            
            
            //                placeholderNameRecipe.topAnchor.constraint(equalTo: nameRecipe.topAnchor, constant: 0),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: nameRecipe.bottomAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 343),
            
            
            instructions.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            instructions.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //instructions.heightAnchor.constraint(equalToConstant: 77),
            instructions.widthAnchor.constraint(equalToConstant: 343),
            
            servesLabel.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 16),
            servesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            servesLabel.heightAnchor.constraint(equalToConstant: 60),
            servesLabel.widthAnchor.constraint(equalToConstant: 343),
            
            cookTimeLabel.topAnchor.constraint(equalTo: servesLabel.bottomAnchor, constant: 16),
            cookTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cookTimeLabel.heightAnchor.constraint(equalToConstant: 60),
            cookTimeLabel.widthAnchor.constraint(equalToConstant: 343),
            
            stackView.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //                stackView.heightAnchor.constraint(equalToConstant: 700),
            stackView.widthAnchor.constraint(equalToConstant: 343),
            
            
            
            
            ingredientsTitle.topAnchor.constraint(equalTo: cookTimeLabel.bottomAnchor, constant: 16),
            ingredientsTitle.leadingAnchor.constraint(equalTo: cookTimeLabel.leadingAnchor),
            
            
            //                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ////                stackView.heightAnchor.constraint(equalToConstant: 700),
            //                stackView.widthAnchor.constraint(equalToConstant: 343),
            //
            //                addIngredientsName.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant: 16),
            addIngredientsName.widthAnchor.constraint(equalToConstant: 162),
            addIngredientsName.heightAnchor.constraint(equalToConstant: 44),
            
            //                addQuantityIngredients.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant: 16),
            //                /*addQuantityIngredients.leftAnchor.constraint(equalTo: addI*/ngredientsName.rightAnchor, constant: 12),
            addQuantityIngredients.widthAnchor.constraint(equalToConstant: 115),
            addQuantityIngredients.heightAnchor.constraint(equalToConstant: 44),
            
            //                addIngredientsBu/*tton.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant: 16),*/
            //                addIngredientsButton.leftAnchor/*.constraint(equalTo: addQuantityIngredients.rightAnchor, consta*/nt: 12),
            //                addIngredientsButton.centerYAnchor.constraint(equalTo: addQuantityIngredients.centerYAnchor),
            
            
            
            
            //                stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ////                stackView.heightAnchor.constraint(equalToConstant: 700),
            //                stackView.widthAnchor.constraint(equalToConstant: 343),
            
            
        ])
    }
}

extension CreateRecipeViewController {
    private func setViews() {
        //            let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        //            let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        //            view1.backgroundColor = .red
        //            view2.backgroundColor = .blue
        //            view1.translatesAutoresizingMaskIntoConstraints = false
        //            view2.translatesAutoresizingMaskIntoConstraints = false
        //            view1.heightAnchor.constraint(equalToConstant: 500).isActive = true
        //            view2.heightAnchor.constraint(equalToConstant: 500).isActive = true
        //            view1.widthAnchor.constraint(equalToConstant: 300).isActive = true
        //            view2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        //
        //
        //            stackView.addArrangedSubview(view1)
        //            stackView.addArrangedSubview(view2)
        let ingredients1 = UIStackView(arrangedSubviews: [addIngredientsName, addQuantityIngredients, addIngredientsButton])
        ingredients1.axis = .horizontal
        ingredients1.spacing = 16
        
        view.addSubview(createRecipeButton)
        view.addSubview(nameRecipe)
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(instructions)
        nameRecipe.addSubviews(placeholderNameRecipe)
        instructions.addSubviews(placeholderInstruction)
        contentView.addSubview(ingredientsTitle)
        //            contentView.addSubview(cookTimeButton)
        contentView.addSubview(servesLabel)
        contentView.addSubview(cookTimeLabel)
        contentView.addSubview(cookTimeImage)
        contentView.addSubview(servesImage)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(ingredients1)
        //            stackView.addSubviews(addIngredientsName)
        //            stackView.addSubviews(addQuantityIngredients)
        //            stackView.isUserInteractionEnabled = true
        //            stackView.bringSubviewToFront(stackView.arrangedSubviews.first!)
        //            view.addSubviews(addIngredientsButton)
    }
}


extension UITextView {
    convenience init(size: CGFloat,numb: Int, weight: UIFont.Weight) {
        self.init()
        self.textContainer.maximumNumberOfLines = numb
        self.isScrollEnabled = false
        //self.sizeToFit()
        self.isEditable = true
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        // self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: size, weight: weight)])
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "redApp")?.cgColor
        self.layer.cornerRadius = 8
        self.keyboardType = .default
        self.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            self.heightAnchor.constraint(equalToConstant: size.height),
        //])
    }
}



extension UITextField {
    convenience init(text: String, size: CGFloat , weight: UIFont.Weight, borderColor: UIColor ) {
        self.init()
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: size, weight: weight)])
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "lightGreyApp")?.cgColor
        self.layer.cornerRadius = 8
        self.keyboardType = .default
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
//extension UILabel {
//    convenience init(text: String, size: Int, Color: String) {
//        self.init()
//        self.text = text
//        self.textColor = .black
//        self.textAlignment = .center
//        self.font = .boldSystemFont(ofSize: CGFloat(size))
//        self.backgroundColor = UIColor(named: String)
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 12
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//}
extension CreateRecipeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.mediaType] as? String == "public.image" {
            self.handlePhoto(info)
        } else {
            print("DEBUG PRINT:", "Media was neither image")
            
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.imagePicker.dismiss(animated: true, completion: nil)
        }
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

extension CreateRecipeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        nameRecipe.delegate = self
        placeholderNameRecipe.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if nameRecipe.text == "" {
            placeholderNameRecipe.isHidden = false
        }
    }
    
}


@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CreateRecipeViewController())
}
