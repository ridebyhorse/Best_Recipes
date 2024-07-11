//
//  DemoViewController.swift
//  Best_Recipes
//
//  Created by Дмитрий Волков on 10.07.2024.
//

import UIKit
import SnapKit

class DemoViewController: UIPageViewController {

    var pages = [UIViewController]()
    
    let skipButton = UIButton()
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // Page controls
    lazy var stepsStack = UIStackView()
    lazy var stepView1 = UIView()
    lazy var stepView2 = UIView()
    lazy var stepView3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        setup()
        style()
        layout()
        setStepsStack()
    }
    
    func setStepsStack(){
        stepsStack.axis = .horizontal
        stepsStack.distribution = .equalSpacing
        stepsStack.spacing = 7
        stepView1.layer.cornerRadius = 5
        stepView2.layer.cornerRadius = 5
        stepView3.layer.cornerRadius = 5
        
    }
}

extension DemoViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
    
        let page1 = OnboardingViewController(imageName: "splash1",
                                             titleText: "Best\nRecipe",
                                             subtitleText: "Find best recipes for cooking",
                                             topText: "✯100k+ premium recipes"
        )
        let page2 = OnboardingViewController(imageName: "splash2",
                                             titleText: "Recipes from\nall over the\nworld",
                                             subtitleText: "",
                                             topText: "")
        let page3 = OnboardingViewController(imageName: "splash3",
                                             titleText: "Recipes with\neach and every\ndetail",
                                             subtitleText: "",
                                             topText: "")
        let page4 = OnboardingViewController(imageName: "splash4",
                                             titleText: "Cook it now or\nsave it for later",
                                             subtitleText: "",
                                             topText: "")
        let page5 = LoginViewController()
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        
        skipButton.tintColor = .white
        skipButton.titleLabel?.font = .custom(font: .regular, size: 16)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)

        nextButton.setTitle("Get started", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        nextButton.titleLabel?.font = .custom(font: .regular, size: 16)
        nextButton.tintColor = .white
        nextButton.backgroundColor = UIColor(named: "redApp")
        nextButton.layer.cornerRadius = 20
    }
    
    func layout() {

        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(stepsStack)
        stepsStack.addArrangedSubview(stepView1)
        stepsStack.addArrangedSubview(stepView2)
        stepsStack.addArrangedSubview(stepView3)

        
        stepsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-25)
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
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(56)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
}

// MARK: - DataSource

extension DemoViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            print("1")
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
        
        
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates

extension DemoViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        updateUI(currentIndex: currentIndex)
        
    
    }
    
    func updateUI(currentIndex: Int) {
        if currentIndex == 0 {
            nextButton.setTitle("Get started", for: .normal)
            stepsStack.removeFromSuperview()
            skipButton.removeFromSuperview()
        }
        if currentIndex == 1 {
            nextButton.setTitle("Continue", for: .normal)
            skipButton.setTitle("Skip", for: .normal)
            stepView1.backgroundColor = UIColor(named: "beigeApp")
            stepView2.backgroundColor = UIColor(named: "greyApp")
            stepView3.backgroundColor = UIColor(named: "greyApp")
        }
        if currentIndex == 2 {
            nextButton.setTitle("Continue", for: .normal)
            skipButton.setTitle("Skip", for: .normal)
            stepView1.backgroundColor = UIColor(named: "greyApp")
            stepView2.backgroundColor = UIColor(named: "beigeApp")
            
        }
        if currentIndex == 3 {
            nextButton.setTitle("Start cooking", for: .normal)
            stepView2.backgroundColor = UIColor(named: "greyApp")
            stepView3.backgroundColor = UIColor(named: "beigeApp")
            skipButton.removeFromSuperview()
        }
    if currentIndex == 4 {
            stepsStack.removeFromSuperview()
            nextButton.removeFromSuperview()
        }
        
    }
    
    
}

// MARK: - Actions

extension DemoViewController {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }

    @objc func skipTapped(_ sender: UIButton) {
        let lastPage = pages.count - 1
        pageControl.currentPage = lastPage
        
        goToSpecificPage(index: lastPage, ofViewControllers: pages)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
    }
}

// MARK: - Extensions

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}

