//
//  UIimageVIew + Extension.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//

import UIKit
import AlamofireImage
extension UIImageView: Configurable {
    struct Model {
        let image: UIImage?
        let url: URL?
        let renderingMode: UIImage.RenderingMode
        let tintColor: UIColor?
        let contenMode: UIImageView.ContentMode
        let size: CGSize?
        let cornerRadius: CGFloat
        
        init(
            image: UIImage? = nil,
            url: URL? = nil,
            renderingMode: UIImage.RenderingMode = .alwaysTemplate,
            tintColor: UIColor? = nil,
            contenMode: UIImageView.ContentMode = .scaleAspectFill,
            size: CGSize? = nil,
            cornerRadius: CGFloat = .zero,
            contentMode: UIView.ContentMode = .scaleAspectFit
            
        ) {
            self.image = image
            self.url = url
            self.renderingMode = renderingMode
            self.tintColor = tintColor
            self.contenMode = contenMode
            self.size = size
            self.cornerRadius = cornerRadius
        }
    }
    
    func update(with model: Model?) {
        guard let model else {
            self.image = nil
            self.af.cancelImageRequest()
            return
        }
        self.image = model.image?.withRenderingMode(model.renderingMode)
        self.tintColor = model.tintColor
        self.contentMode = model.contenMode
        self.clipsToBounds = true
        self.layer.cornerRadius = model.cornerRadius
        self.contentMode = model.contenMode
        
        if let size = model.size {
            snp.remakeConstraints {
                $0.size.equalTo(size)
            }
        }
        
        if let url = model.url {
            self.af.setImage(withURL: url)
        }
    }
}
