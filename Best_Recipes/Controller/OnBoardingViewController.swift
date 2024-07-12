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
    
    init(imageName: String, titleText: String, subtitleText: String, topText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        toptitleLabel.text = topText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController {
    
    func style() {
        
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .custom(font: .bold, size: 56)
        titleLabel.numberOfLines = 0
        
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
}
