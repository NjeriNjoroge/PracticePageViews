//
//  FinalViewController.swift
//  Final
//
//  Created by Grace on 10/01/2018.
//  Copyright © 2018 Grace. All rights reserved.
//

import UIKit

class FinalViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var VCArr:[UIViewController] = {
        return [self.VCInstance(name: "RedView"),
                self.VCInstance(name: "GreenView"),
                self.VCInstance(name: "YellowView")
    ]}()
    
    private func VCInstance(name: String)-> UIViewController {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = VCArr.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        //changing color on dots
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.white
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
        
    }
    
//making the scroll part transparent
   override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    for view in self.view.subviews {
        if view is UIScrollView {
            view.frame = UIScreen.main.bounds
        } else if view is UIPageControl {
            view.backgroundColor = UIColor.clear
        }
    }
    

    
    }
    

    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
            
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArr.last
        }
        
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        return VCArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else {
            return nil
        }
        
        guard VCArr.count > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]
        
    }
  
//for the dots below
//shows how many scrolls to go through
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }
   
//shows your current pageview when scrolling
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}



        


