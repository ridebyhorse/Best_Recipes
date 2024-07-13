//
//  CreateRecipeViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit
import Photos
import MobileCoreServices

class CreateRecipeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let storageServise = StorageService.shared
    
    var imageURLToSave: URL?
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    
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
        cookTimeImage.image = UIImage(named: "ClockTime")
        cookTimeImage.contentMode = .scaleAspectFit
        cookTimeImage.backgroundColor = .white
        cookTimeImage.layer.cornerRadius = 12
        cookTimeImage.clipsToBounds = true
        cookTimeImage.isUserInteractionEnabled = true
        cookTimeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeImage.leadingAnchor.constraint(equalTo: cookTimeLabel.leadingAnchor, constant: 16),
            cookTimeImage.centerYAnchor.constraint(equalTo: cookTimeLabel.centerYAnchor),
        ])
    }
    private func setServesImage() {
        servesImage.image = UIImage(named: "ServesSum")
        servesImage.contentMode = .scaleAspectFit
        servesImage.isUserInteractionEnabled = true
        servesImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesImage.leadingAnchor.constraint(equalTo: servesLabel.leadingAnchor, constant: 16),
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
    
    
    private var servesSum = UILabel()
    //(frame: CGRect(x: 250, y: 477, width: 20, height: 20))
    private var cookTimeSum = UILabel()
//    (frame: CGRect(x: 270, y: 553, width: 200, height: 20))
    
    
    private func setServesAndCookSum() {
        cookTimeSum.text = "00 min"
        servesSum.text = "01"
        
        servesSum.translatesAutoresizingMaskIntoConstraints = false
        cookTimeSum.translatesAutoresizingMaskIntoConstraints = false
//        cookTimeSum.backgroundColor = .red
        
//        servesSum.textColor = .black
//        servesSum.backgroundColor = .green
        
//        view.addSubview(servesSum)
//        view.addSubview(cookTimeSum)
        
//        NSLayoutConstraint.activate([
//            servesSum.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
//            servesSum.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            servesSum.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            servesSum.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
            
//            cookTimeSum.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -56),
//            cookTimeSum.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//            NSLayoutConstraint.activate([
//                //cookTimeSum.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
//                cookTimeSum.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                cookTimeSum.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////                cookTimeSum.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
//                cookTimeSum.heightAnchor.constraint(equalToConstant: 32),
//                cookTimeSum.widthAnchor.constraint(equalToConstant: 32)
//            ])
//        ])
        
        
    }
    
    var serves = Array(1...12).map { String ($0) }
    
    var cookTimeHours = Array(0...24).map { String ($0) }
    
    //var CookTesto = [ "01", "02", "03", "04", "05", "06", "07" ]
    
    var cookTimeMinuts: Array = Array(0...59).map { String ($0) }
//    print(cookTimeMinuts)
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    var selectedRow1 = 1
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == pickerView1 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(serves)[row]
            label.sizeToFit()
            return label
        } else {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
//            label.text = Array(cookTimeHours)[row]
            switch component {
            case 0:
                label.text = Array(cookTimeHours)[row]
            default:
                label.text = Array(cookTimeMinuts)[row]
            }
            label.sizeToFit()
            return label
        }
        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
//        label.text = Array(cookTime)[row].key
//        label.sizeToFit()
//        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerView1 {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return serves.count
        } else {
//            return cookTimeHours.count
            switch component {
            case 0:
                return cookTimeHours.count
            default:
                return cookTimeMinuts.count
            }
//            return cookTimeMinuts.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        if pickerView == pickerView1 {
//            return 60
//        } else {
//            return 60
//        }
       /* return*/ 60
    }
    private let servesButton = UIButton(type: .system)
    private let cookTimeButton = UIButton(type: .system)
    
    private func setServesAndCookButtons() {
        servesButton.translatesAutoresizingMaskIntoConstraints = false
        servesButton.setImage(UIImage(named: "Arrow-Right"), for: .normal)
        servesButton.tintColor = .black
        servesButton.addTarget(self, action: #selector(selectedServes), for: .touchUpInside)
        
        
        cookTimeButton.translatesAutoresizingMaskIntoConstraints = false
        cookTimeButton.setImage(UIImage(named: "Arrow-Right"), for: .normal)
        cookTimeButton.tintColor = .black
        cookTimeButton.addTarget(self, action: #selector(selectedTime), for: .touchUpInside)
        
//        contentView.addSubview(servesButton)
//        contentView.addSubview(cookTimeButton)
        
//        NSLayoutConstraint.activate([
//            servesButton.trailingAnchor.constraint(equalTo: servesLabel.trailingAnchor, constant: -16),
//            servesButton.centerYAnchor.constraint(equalTo: servesLabel.centerYAnchor),
//
//            cookTimeButton.trailingAnchor.constraint(equalTo: cookTimeLabel.trailingAnchor, constant: -16),
//            cookTimeButton.centerYAnchor.constraint(equalTo: cookTimeLabel.centerYAnchor)
//        ])
        
    }
    @objc private func selectedTime() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        pickerView1.isHidden = false
        pickerView2.isHidden = true
        
        pickerView2 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        pickerView2.dataSource = self
        pickerView2.delegate = self
        
        
        pickerView2.selectRow(selectedRow, inComponent: 0, animated: false)
        pickerView2.selectRow(selectedRow1, inComponent: 1, animated: false)
        
        vc.view.addSubview(pickerView2)
        pickerView2.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView2.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Cook Time", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = cookTimeButton
        alert.popoverPresentationController?.sourceRect = cookTimeButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancele", style: .cancel, handler: { (UIAlertAction)
            in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction)
            in
            self.selectedRow = self.pickerView2.selectedRow(inComponent: 0)
            self.selectedRow1 = self.pickerView2.selectedRow(inComponent: 1)
            let selected = Array( self.cookTimeHours)[self.selectedRow]
            let selected1 = Array( self.cookTimeMinuts)[self.selectedRow1]

            
//            let color = selected.value
            let name = selected
            let name1 = selected1

            //
            self.cookTimeSum.text = ("\(name) hour \(name1) min")
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
   
    @objc private func selectedServes() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        
        pickerView1.isHidden = true
        pickerView2.isHidden = false
        
        pickerView1 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView1.dataSource = self
        pickerView1.delegate = self
        
        pickerView1.selectRow(selectedRow, inComponent: 0, animated: false)
//        pickerView1.selectRow(selectedRow1, inComponent: 1, animated: false)

        
        vc.view.addSubview(pickerView1)
        pickerView1.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView1.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Serves", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = servesButton
        alert.popoverPresentationController?.sourceRect = servesButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancele", style: .cancel, handler: { (UIAlertAction)
            in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction)
            in
            self.selectedRow = self.pickerView1.selectedRow(inComponent: 0)
//            self.selectedRow1 = self.pickerView1.selectedRow(inComponent: 1)
            let selected = Array( self.serves)[self.selectedRow]
//            let selected1 = Array( self.serves)[self.selectedRow1]
            //let color = selected.value
            let name = selected
//            let name1 = selected1.key
            //
            //self.servesSum.text = (name)
            self.servesSum.text = (name)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
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
        createRecipeButton.onTap = { [weak self] in
            self?.saveRecipe()
            self?.dismiss(animated: true)
        }
        nameRecipe.delegate = self
        instructions.delegate = self
//
////        pickerView1.delegate = self
//        pickerView1.dataSource = self
//        pickerView1.isHidden = true
//
//        pickerView2.delegate = self
//        pickerView2.dataSource = self
//        pickerView2.isHidden = true
//
        
        
        PHPhotoLibrary.authorizationStatus()
        PHPhotoLibrary.requestAuthorization { _ in }
        
        view.backgroundColor = .white
        
        setViews()
        setupConstraints()
        createButtons()
        setServesImage()
        setCookTimeImage()
        setCookTimeLabel()
        setServesAndCookButtons()
        setServesAndCookSum()
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
    
    
    func saveRecipe() {
            var ingridientsToSave = [Ingridient]()
            let instructionsToSave = [Instruction(steps: [InstructionStep(number: 1, step: instructions.text)])]
            stackView.arrangedSubviews.forEach({
                if !$0.isHidden {
                    let stack = $0 as! UIStackView
                    let nameField = stack.arrangedSubviews[0] as! UITextField
                    let amountField = stack.arrangedSubviews[1] as! UITextField
                    let name = nameField.text ?? "Unknown ingridient"
                    var stringAmount = ""
                    var unit = ""
                    let amountCharArray = Array(amountField.text ?? "0")
                    for char in amountCharArray {
                        if char.isNumber {
                            stringAmount.append(char)
                        } else {
                            unit.append(char)
                        }
                    }
                    ingridientsToSave.append(Ingridient(originalName: name, amount: Double(stringAmount) ?? 0, unit: unit))
                }
                ingridientsToSave.append(Ingridient(id: UUID().hashValue, originalName: name, amount: Double(stringAmount) ?? 0, unit: unit))
            }
        })

            let name = Int(Array( self.cookTimeHours)[self.pickerView2.selectedRow(inComponent: 0)]) ?? 0
            let name1 = Int(Array( self.cookTimeMinuts)[self.pickerView2.selectedRow(inComponent: 1)]) ?? 0
            let id = name + name1 + Int(ingridientsToSave.first?.amount ?? 0) + Int.random(in: 1...99) + Int.random(in: 1...99)
            
            let recipe = Recipe(rating: 0, id: id, title: nameRecipe.text, countries: [], categories: [], cookingTime: name * 60 + name1, isTrending: false, reviewsCount: 0, author: storageServise.getUser().name, ingredients: ingridientsToSave, instructions: instructionsToSave, image: imageURLToSave)
            print(recipe)
            storageServise.saveCreatedRecipe(recipe)
            
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createRecipeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 56),
            createRecipeButton.widthAnchor.constraint(equalToConstant: 343),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor, constant: -16),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            nameRecipe.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameRecipe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameRecipe.widthAnchor.constraint(equalToConstant: 343),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: nameRecipe.bottomAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 343),
            
            instructions.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            instructions.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            instructions.heightAnchor.constraint(equalToConstant: 77),
//            instructions.widthAnchor.constraint(equalToConstant: 343),
            instructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            instructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            servesLabel.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 16),
            servesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            servesLabel.heightAnchor.constraint(equalToConstant: 60),
//            servesLabel.widthAnchor.constraint(equalToConstant: 343),
            servesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            servesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            cookTimeLabel.topAnchor.constraint(equalTo: servesLabel.bottomAnchor, constant: 16),
            cookTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cookTimeLabel.heightAnchor.constraint(equalToConstant: 60),
//            cookTimeLabel.widthAnchor.constraint(equalToConstant: 343),
            cookTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cookTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            servesButton.trailingAnchor.constraint(equalTo: servesLabel.trailingAnchor, constant: -16),
            servesButton.centerYAnchor.constraint(equalTo: servesLabel.centerYAnchor),
            
            cookTimeButton.trailingAnchor.constraint(equalTo: cookTimeLabel.trailingAnchor, constant: -16),
            cookTimeButton.centerYAnchor.constraint(equalTo: cookTimeLabel.centerYAnchor),
            
            servesSum.trailingAnchor.constraint(equalTo: servesButton.leadingAnchor, constant: -20),
            servesSum.centerYAnchor.constraint(equalTo: servesButton.centerYAnchor),
            
            cookTimeSum.trailingAnchor.constraint(equalTo: cookTimeButton.leadingAnchor, constant: -20),
            cookTimeSum.centerYAnchor.constraint(equalTo: cookTimeButton.centerYAnchor),
            
                        
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
        
        contentView.addSubview(servesButton)
        contentView.addSubview(cookTimeButton)
        
        stackView.addArrangedSubviews(ingredients1)
        
        nameRecipe.addSubviews(placeholderNameRecipe)
        instructions.addSubviews(placeholderInstruction)
        
        
        contentView.addSubview(servesSum)
        contentView.addSubview(cookTimeSum)
    }
}

extension UITextView {
    convenience init(size: CGFloat, numb: Int, weight: UIFont.Weight) {
        self.init()
        self.tag = numb
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
            imageURLToSave = imageURL
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
    func textViewDidChange(_ textView: UITextView) {
        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
        placeholderInstruction.isHidden = !instructions.text.isEmpty
    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        placeholderNameRecipe.isHidden = !nameRecipe.text.isEmpty
//        placeholderInstruction.isHidden = !instructions.text.isEmpty
//    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        switch textView.tag {
//        case 0:
//            placeholderInstruction.isHidden = true
//        default:
//            placeholderNameRecipe.isHidden = true
//        }
//    }
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
