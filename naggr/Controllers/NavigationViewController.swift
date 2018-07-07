//
//  HomeViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 8/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController, HomePagerViewControllerDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pagerViewController = segue.destination as? HomePagerViewController {
            pagerViewController.pagerDelegate = self
        }
    }
    
    func onPageCountChange(count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onPageIndexChange(index: Int) {
        pageControl.currentPage = index
    }
    
}
