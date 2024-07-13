//
//  DemoViewController.swift
//  Best_Recipes
//
//  Created by Дмитрий Волков on 10.07.2024.
//

import UIKit
import SnapKit

class DemoViewController: UIPageViewController {

    var completionHandler: (() -> Void)?
    var pages = [UIViewController]()
    
    let skipButton = UIButton()
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        setup()
        style()
        layout()
    }

}

extension DemoViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
    
        let page1 = OnboardingViewController(imageName: "Onboarding1",
                                             titleText: "Best\nRecipe",
                                             subtitleText: "Find best recipes for cooking",
                                             topText: "✯100k+ premium recipes",
                                             isMain: true
        )
        let page2 = OnboardingViewController(imageName: "Onboarding2",
                                             titleText: "Recipes from\nall over the\nworld",
                                             subtitleText: "",
                                             topText: "",
                                            isMain: false)
        let page3 = OnboardingViewController(imageName: "Onboarding3",
                                             titleText: "Recipes with\neach and every\ndetail",
                                             subtitleText: "",
                                             topText: "",
                                             isMain: false)
        let page4 = OnboardingViewController(imageName: "Onboarding4",
                                             titleText: "Cook it now or\nsave it for later",
                                             subtitleText: "",
                                             topText: "",
                                             isMain: false)
//        let page5 = LoginViewController()
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
//        pages.append(page5)
        
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

//MARK: - updateUI - button text, skip button, controllers

extension DemoViewController {
    func updateUI(currentIndex: Int) {
        if currentIndex == 0 {
            nextButton.setTitle("Get started", for: .normal)
            skipButton.setTitle("", for: .normal)
            skipButton.isUserInteractionEnabled = false
        }
        if currentIndex == 1 {
            nextButton.setTitle("Continue", for: .normal)
            skipButton.setTitle("Skip", for: .normal)
            skipButton.isUserInteractionEnabled = true
        }
        if currentIndex == 2 {
            nextButton.setTitle("Continue", for: .normal)
            skipButton.setTitle("Skip", for: .normal)
            skipButton.isUserInteractionEnabled = true
            
        }
        if currentIndex == 3 {
            nextButton.setTitle("Start cooking", for: .normal)
            skipButton.setTitle("", for: .normal)
            skipButton.isUserInteractionEnabled = false
        }
        if currentIndex == 4 {
            nextButton.removeFromSuperview()
        }
        
    }
}


// MARK: - DataSource
extension DemoViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
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
            completionHandler?()
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
        print(pageControl.currentPage) // только при тапе на экран
        
        updateUI(currentIndex: currentIndex)
        
    
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
        
        guard let currentIndex = pages.firstIndex(of: (viewControllers?[0])!) else { return }
        updateUI(currentIndex: currentIndex)

        
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


