//
//  ViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 7/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit

class HomePagerViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var nagViewControllers: [NagViewController] = []
    var pageControl = UIPageControl()
    var pagerDelegate: HomePagerViewControllerDelegate?
    var lastPendingIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNags()
        
        dataSource = self
        delegate = self
        
        pagerDelegate?.onPageCountChange(count: nagViewControllers.count)
        
        if let intialViewController = nagViewControllers.first {
            setViewControllers([intialViewController], direction: .forward,
                               animated: true, completion: nil)
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return nagViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func createControllerFor(_ nag: Nag) -> NagViewController {
        let nagViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "nagViewController")
            as! NagViewController
        
        nagViewController.nag = nag
        
        return nagViewController
    }
    
    func fetchNags() {
        for i in 0...5 {
            let nag = Nag(name: "Mother Dearest \(i)",
                number: "0450500490", lastCalled: Date())
            
            nagViewControllers.append(createControllerFor(nag))
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Get current state variable
        guard let currentIndex = getIndex(of: viewController) else  { return nil }
        let previousIndex = currentIndex - 1
        
        // Check if the call is out of bounds
        guard previousIndex >= 0 || -1 != previousIndex else {
            return nil
        }
        
        // Return the new viewController
        return nagViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Get current state variable
        guard let currentIndex = getIndex(of: viewController) else  { return nil }
        let nextIndex = currentIndex + 1
        let count = nagViewControllers.count
        
        // Check if the call is out of bounds
        guard count != nextIndex || count > nextIndex else {
            return nil
        }
        
        // Return the new viewController
        return nagViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // Get the current index and update the pager
        if let viewControllers = pageViewController.viewControllers {
            if let currentIndex = nagViewControllers.index(of: viewControllers[0] as! NagViewController) {
                pagerDelegate?.onPageIndexChange(index: currentIndex)
            }
        }
    }
    
    private func getIndex(of viewController: UIViewController) -> Int? {
        // Return the index of the nag if found
        if let index = nagViewControllers.index(of: viewController as! NagViewController) {
            return index
        }
        return nil
    }
}

protocol HomePagerViewControllerDelegate {
    func onPageCountChange(count: Int)
    func onPageIndexChange(index: Int)
}

