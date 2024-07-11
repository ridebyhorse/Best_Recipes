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
        scrollView.contentSize = contenSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        
        let contentView = UIView()
        contentView.frame.size = contenSize
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
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
        cookTimeImage.clipsToBounds = true
        cookTimeImage.isUserInteractionEnabled = true
        cookTimeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeImage.leftAnchor.constraint(equalTo: cookTimeLabel.leftAnchor, constant: 16),
            cookTimeImage.centerYAnchor.constraint(equalTo: cookTimeLabel.centerYAnchor),
        ])
    }
    private func setServesImage() {
        servesImage.image = UIImage(named: "Icon - Serves")
        servesImage.contentMode = .scaleAspectFit
        servesImage.isUserInteractionEnabled = true
        servesImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesImage.leftAnchor.constraint(equalTo: servesLabel.leftAnchor, constant: 16),
            servesImage.centerYAnchor.constraint(equalTo: servesLabel.centerYAnchor),
        ])
    }
        
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
    
    private func buttonTappedAdd(sender: UIButton) {
        if sender.currentImage == UIImage(named: "Plus-Border") {
            sender.setImage(UIImage(named: "Minus-Border"), for: .normal)
            let newRow = createRow()
            stackView.addArrangedSubview(newRow)
        } else {
            sender.setImage(UIImage(named: "Plus-Border"), for: .normal)
            stackView.arrangedSubviews[sender.tag].isHidden = true
            }
        }

    private func createRow() -> UIStackView {
        let row = IngredienStackView()
        row.onTap = {[ weak self] in
            self?.buttonTappedAdd(sender: $0)
        }
        return row
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
        //        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
        //placeholderNameRecipe.isHidden = true
        placeholderNameRecipe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderNameRecipe.leadingAnchor.constraint(equalTo: nameRecipe.leadingAnchor, constant: 15),
            placeholderNameRecipe.topAnchor.constraint(equalTo: nameRecipe.topAnchor),
            placeholderNameRecipe.centerYAnchor.constraint(equalTo: nameRecipe.centerYAnchor)
        ])
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
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor, constant: -16),
            
            nameRecipe.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameRecipe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameRecipe.widthAnchor.constraint(equalToConstant: 343),
            
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
            stackView.widthAnchor.constraint(equalToConstant: 343),
         
            ingredientsTitle.topAnchor.constraint(equalTo: cookTimeLabel.bottomAnchor, constant: 16),
            ingredientsTitle.leadingAnchor.constraint(equalTo: cookTimeLabel.leadingAnchor),
            
            addIngredientsName.widthAnchor.constraint(equalToConstant: 162),
            addIngredientsName.heightAnchor.constraint(equalToConstant: 44),
 
            addQuantityIngredients.widthAnchor.constraint(equalToConstant: 115),
            addQuantityIngredients.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

extension CreateRecipeViewController {
    private func setViews() {

        let ingredients1 = createRow()

        view.addSubview(createRecipeButton)
        view.addSubview(nameRecipe)
        view.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(instructions)
        contentView.addSubview(ingredientsTitle)
        contentView.addSubview(servesLabel)
        contentView.addSubview(cookTimeLabel)
        contentView.addSubview(cookTimeImage)
        contentView.addSubview(servesImage)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubviews(ingredients1)
        
        nameRecipe.addSubviews(placeholderNameRecipe)
        instructions.addSubviews(placeholderInstruction)
    }
}

extension UITextView {
    convenience init(size: CGFloat,numb: Int, weight: UIFont.Weight) {
        self.init()
        self.textContainer.maximumNumberOfLines = numb
        self.isScrollEnabled = false
        self.sizeToFit()
        self.isEditable = true
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "redApp")?.cgColor
        self.layer.cornerRadius = 8
        self.keyboardType = .default
        self.translatesAutoresizingMaskIntoConstraints = false
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
    func textViewDidChange() {
        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderNameRecipe.isHidden = true
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CreateRecipeViewController())
}


class IngredienStackView: UIStackView {
    
    var onTap: ((UIButton) -> Void)?
    static var taggg = 0
    
    let addIngredients = UITextField(text: "   Item name", size: 14, weight: .regular, borderColor: UIColor(named: "ColorBorder")!)
    let addQuantity = UITextField(text: "   Quantity", size: 14, weight: .regular, borderColor: UIColor(named: "ColorBorder")!)
    
    private let addIngredientsButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        addIngredientsButton.tintColor = .black
        addIngredientsButton.backgroundColor = .white
        addIngredientsButton.setImage(UIImage(named: "Plus-Border"), for: .normal)
        addIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        addIngredientsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addIngredientsButton.tag = IngredienStackView.taggg
        IngredienStackView.taggg += 1
        [addIngredients,addIngredients,addIngredients].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            addIngredients.widthAnchor.constraint(equalToConstant: 162),
            addIngredients.heightAnchor.constraint(equalToConstant: 44),
            
            addQuantity.widthAnchor.constraint(equalToConstant: 115),
            addQuantity.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        addArrangedSubviews(addIngredients,addQuantity, addIngredientsButton)
        axis = .horizontal
        spacing = 16
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        onTap?(sender)
    }
}
