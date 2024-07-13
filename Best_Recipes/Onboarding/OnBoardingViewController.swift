//
//  OnBoardingViewController.swift
//  Best_Recipes
//
//  Created by Дмитрий Волков on 02.07.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
        
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let toptitleLabel = UILabel()
    var isMain = Bool()
    
    let stepsStack = UIStackView()
    let stepView1 = UIView()
    let stepView2 = UIView()
    let stepView3 = UIView()
    
    init(imageName: String, titleText: String, subtitleText: String, topText: String, isMain: Bool) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        toptitleLabel.text = topText
        self.isMain = isMain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
        if !isMain {
            setStepsStack()
        }
        
    }
}

extension OnboardingViewController {
    
    func style() {
        
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        //titleLabel.font = .custom(font: .bold, size: 40)
        titleLabel.numberOfLines = 0
        if isMain {
            titleLabel.font = .custom(font: .bold, size: 56)
        } else {
            titleLabel.font = .custom(font: .bold, size: 40)
            
        }
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.font = .custom(font: .regular, size: 16)
        subtitleLabel.numberOfLines = 0
        
        toptitleLabel.textAlignment = .center
        toptitleLabel.textColor = .white
        toptitleLabel.font = .custom(font: .regular, size: 16)
        toptitleLabel.numberOfLines = 0
        
    }
        
    func layout() {
        view.addSubview(imageView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(subtitleLabel)
        imageView.addSubview(toptitleLabel)
        imageView.addSubview(stepsStack)
        stepsStack.addArrangedSubview(stepView1)
        stepsStack.addArrangedSubview(stepView2)
        stepsStack.addArrangedSubview(stepView3)

        
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-200)
            make.left.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-170)
            make.left.right.equalToSuperview()
        }
        
        toptitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    func setStepsStack(){
        stepsStack.axis = .horizontal
        stepsStack.distribution = .equalSpacing
        stepsStack.spacing = 7
        stepView1.layer.cornerRadius = 5
        stepView2.layer.cornerRadius = 5
        stepView3.layer.cornerRadius = 5
        
        
        if titleLabel.text == "Recipes with\neach and every\ndetail" {
            stepView1.backgroundColor = UIColor(named: "greyApp")
            stepView2.backgroundColor = UIColor(named: "beigeApp")
            stepView3.backgroundColor = UIColor(named: "greyApp")
        } else if titleLabel.text == "Cook it now or\nsave it for later" {
            stepView1.backgroundColor = UIColor(named: "greyApp")
            stepView2.backgroundColor = UIColor(named: "greyApp")
            stepView3.backgroundColor = UIColor(named: "beigeApp")
        } else {
            stepView1.backgroundColor = UIColor(named: "beigeApp")
            stepView2.backgroundColor = UIColor(named: "greyApp")
            stepView3.backgroundColor = UIColor(named: "greyApp")
        }
        
        stepsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-165)
        }
        stepView1.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(8)
        }
        stepView2.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(8)
        }
        stepView3.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(8)
        }
        
    }
}

