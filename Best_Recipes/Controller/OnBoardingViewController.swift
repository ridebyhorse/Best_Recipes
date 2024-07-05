//
//  OnBoardingViewController.swift
//  Best_Recipes
//
//  Created by Дмитрий Волков on 02.07.2024.
//

import UIKit
import SnapKit


class OnBoardingViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl() // external - not part of underlying pages
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension OnBoardingViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        // create an array of viewController
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        let page4 = ViewController4()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        // set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - Actions

extension OnBoardingViewController {
    
    // How we change page when pageControl tapped.
    // Note - Can only skip ahead on page at a time.
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSources

extension OnBoardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex != 0 {
            return pages[currentIndex - 1]  // go previous
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap to first
        }
    }
}

// MARK: - Delegates

extension OnBoardingViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Extensions for elements

extension UIImageView {
    convenience init(name: String) {
        self.init()
        self.image = UIImage(named: name)
        self.contentMode = .scaleAspectFill
    }
}

extension UILabel {
    convenience init(fontSize: CGFloat, text: String) {
        self.init()
        self.text = text
        self.textColor = .white
        self.textAlignment = .center
        self.font = .custom(font: .bold, size: fontSize)
        self.numberOfLines = 0
    }
}

extension UIButton {
    convenience init(fontSize: CGFloat, text: String, corner: CGFloat, color: UIColor?) {
        self.init()
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .custom(font: .regular, size: fontSize)
        self.tintColor = .white
        if let color = color {
            self.backgroundColor = color
        }
        self.layer.cornerRadius = corner
    }
}

// MARK: - ViewControllers

class ViewController1: UIViewController {
    lazy var backgroundImage = UIImageView(name: "Onboarding1")
    lazy var topLabel = UILabel(fontSize: CGFloat(16), text: "✯100k+ premium recipes")
    lazy var button = UIButton(fontSize: CGFloat(16), text: "Get started", corner: 12, color: UIColor(named: "redApp"))
    lazy var descriptionLabel = UILabel(fontSize: CGFloat(16), text: "Find best recipes for cooking")
    lazy var headingLabel = UILabel(fontSize: CGFloat(56), text: "Best\nRecipe")
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
}

class ViewController2: UIViewController {
    lazy var backgroundImage = UIImageView(name: "Onboarding2")
    lazy var skipButton = UIButton(fontSize: CGFloat(16), text: "Skip", corner: 0, color: nil)
    lazy var button = UIButton(fontSize: CGFloat(16), text: "Continue", corner: 20, color: UIColor(named: "redApp"))
    lazy var headingLabel = UILabel(fontSize: CGFloat(40), text: "Recipes from\nall over the\nworld")
    lazy var stepsStack = UIStackView()
    lazy var stepView1 = UIView()
    lazy var stepView2 = UIView()
    lazy var stepView3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setStepsStack()
        setConstraints()
    }
}

class ViewController3: UIViewController {
    lazy var backgroundImage = UIImageView(name: "Onboarding3")
    lazy var skipButton = UIButton(fontSize: CGFloat(16), text: "Skip", corner: 0, color: nil)
    lazy var button = UIButton(fontSize: CGFloat(16), text: "Continue", corner: 20, color: UIColor(named: "redApp"))
    lazy var headingLabel = UILabel(fontSize: CGFloat(40), text: "Recipes with\neach and every\ndetail")
    lazy var stepsStack = UIStackView()
    lazy var stepView1 = UIView()
    lazy var stepView2 = UIView()
    lazy var stepView3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setStepsStack()
        setConstraints()
    }
}

class ViewController4: UIViewController {
    lazy var backgroundImage = UIImageView(name: "Onboarding4")
    lazy var button = UIButton(fontSize: CGFloat(16), text: "Continue", corner: 20, color: UIColor(named: "redApp"))
    lazy var headingLabel = UILabel(fontSize: CGFloat(40), text: "Cook it now or\nsave it for later")
    lazy var stepsStack = UIStackView()
    lazy var stepView1 = UIView()
    lazy var stepView2 = UIView()
    lazy var stepView3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setStepsStack()
        setConstraints()
    }
}

// MARK: - Extensions for ViewControllers

extension ViewController1 {
    func setupUI(){
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(topLabel)
        backgroundImage.addSubview(button)
        backgroundImage.addSubview(descriptionLabel)
        backgroundImage.addSubview(headingLabel)
    }
    func setConstraints(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(56)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-30)
            make.left.right.equalToSuperview()
        }
        headingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-30)
            make.left.right.equalToSuperview()
        }
    }
}

extension ViewController2 {
    func setupUI(){
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(skipButton)
        backgroundImage.addSubview(button)
        backgroundImage.addSubview(headingLabel)
        backgroundImage.addSubview(stepsStack)
        stepsStack.addArrangedSubview(stepView1)
        stepsStack.addArrangedSubview(stepView2)
        stepsStack.addArrangedSubview(stepView3)
    }
    func setConstraints(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(193)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(skipButton.snp.top).offset(-10)
        }
        headingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stepsStack.snp.top).offset(-30)
            make.left.right.equalToSuperview()
        }
        stepsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-25)
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
    func setStepsStack(){
        stepsStack.axis = .horizontal
        stepsStack.distribution = .equalSpacing
        stepsStack.spacing = 7
        stepView1.backgroundColor = UIColor(named: "beigeApp")
        stepView2.backgroundColor = UIColor(named: "greyApp")
        stepView3.backgroundColor = UIColor(named: "greyApp")
        stepView1.layer.cornerRadius = 5
        stepView2.layer.cornerRadius = 5
        stepView3.layer.cornerRadius = 5
        
    }
}

extension ViewController3 {
    func setupUI(){
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(skipButton)
        backgroundImage.addSubview(button)
        backgroundImage.addSubview(headingLabel)
        backgroundImage.addSubview(stepsStack)
        stepsStack.addArrangedSubview(stepView1)
        stepsStack.addArrangedSubview(stepView2)
        stepsStack.addArrangedSubview(stepView3)
    }
    func setConstraints(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(193)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(skipButton.snp.top).offset(-10)
        }
        headingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-50)
            make.left.right.equalToSuperview()
        }
        stepsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-25)
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
    func setStepsStack(){
        stepsStack.axis = .horizontal
        stepsStack.distribution = .equalSpacing
        stepsStack.spacing = 7
        stepView1.backgroundColor = UIColor(named: "greyApp")
        stepView2.backgroundColor = UIColor(named: "beigeApp")
        stepView3.backgroundColor = UIColor(named: "greyApp")
        stepView1.layer.cornerRadius = 5
        stepView2.layer.cornerRadius = 5
        stepView3.layer.cornerRadius = 5
        
    }
}

extension ViewController4 {
    func setupUI(){
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(button)
        backgroundImage.addSubview(headingLabel)
        backgroundImage.addSubview(stepsStack)
        stepsStack.addArrangedSubview(stepView1)
        stepsStack.addArrangedSubview(stepView2)
        stepsStack.addArrangedSubview(stepView3)
    }
    func setConstraints(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(193)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        headingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-50)
            make.left.right.equalToSuperview()
        }
        stepsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-25)
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
    func setStepsStack(){
        stepsStack.axis = .horizontal
        stepsStack.distribution = .equalSpacing
        stepsStack.spacing = 7
        stepView1.backgroundColor = UIColor(named: "greyApp")
        stepView2.backgroundColor = UIColor(named: "greyApp")
        stepView3.backgroundColor = UIColor(named: "beigeApp")
        stepView1.layer.cornerRadius = 5
        stepView2.layer.cornerRadius = 5
        stepView3.layer.cornerRadius = 5
        
    }
}
