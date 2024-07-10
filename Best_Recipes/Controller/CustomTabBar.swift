//
//  CustomTabBar.swift
//  Best_Recipes
//
//  Created by Сергей Сухарев on 02.07.2024.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    var onPlusButtonTap: (() -> Void)?
    
    private let plusButton = PlusButton(type: .system)
    
    override func draw(_ rect: CGRect) {
        configureShape()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBar()
        setupPlusButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    
    private func setupTabBar() {
        tintColor = .red
    }
    
    private func setupPlusButton(){
        addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: topAnchor, constant: -6),
            plusButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            plusButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
        
        plusButton.onTap = {[weak self] in
            self?.onPlusButtonTap?()
        }
    }
    
    //MARK: Hit test
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        plusButton.frame.contains(point) ? plusButton : super.hitTest(point, with: event)
    }
}

//MARK: - Draw Shape

extension CustomTabBar {
    
    private func configureShape() {
        let path = getTabBarPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        layer.insertSublayer(shape, at: 0)
        layer.shadowColor = UIColor(named: "ShadowColor")? .cgColor
        layer.shadowOpacity = 0.1
    }
    
    private func getTabBarPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: -6))
        path.addLine(to: CGPoint(x: 100, y: -6))
        
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: -6),
                    radius: 35,
                    startAngle: .pi,
                    endAngle: .pi * 2,
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: frame.width, y: -6))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        
//        path.addCurve(to: CGPoint(x: 0, y: 0),
//                      controlPoint1: CGPoint(x: 0, y: 0),
//                      controlPoint2: CGPoint(x: 0, y: 0))
        

        return path
    }
}
