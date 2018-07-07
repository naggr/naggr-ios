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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNags()
        
        dataSource = self
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
            let nag = Nag(id: i, name: "Mother Dearest \(i)", number: "0450500490")
            nagViewControllers.append(createControllerFor(nag))
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = nagViewControllers.index(of: viewController as! NagViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard nagViewControllers.count > previousIndex else {
            return nil
        }
        
        pagerDelegate?.onPageIndexChange(index: previousIndex)
        return nagViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = nagViewControllers.index(of: viewController as! NagViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = nagViewControllers.count
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        guard viewControllersCount > nextIndex else {
            return nil
        }
        
        pagerDelegate?.onPageIndexChange(index: nextIndex)
        return nagViewControllers[nextIndex]
    }
}

protocol HomePagerViewControllerDelegate {

    func onPageCountChange(count: Int)
    
    func onPageIndexChange(index: Int)
}

