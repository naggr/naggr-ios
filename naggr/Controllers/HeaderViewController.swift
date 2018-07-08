//
//  HomeViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 8/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class HeaderViewController: UIViewController, HomePagerViewControllerDelegate, CNContactPickerDelegate {

    @IBOutlet weak var addButtonBox: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pagerViewController = segue.destination as? HomePagerViewController {
            pagerViewController.pagerDelegate = self
        }
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        print("clicked")
    }
    
    func onPageCountChange(count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onPageIndexChange(index: Int) {
        pageControl.currentPage = index
    }
    
    private func styleView() {
        // Button styling
        addButtonBox.layer.cornerRadius = addButtonBox.frame.size.width / 2;
        addButtonBox.layer.shadowColor = UIColor.black.cgColor
        addButtonBox.layer.shadowRadius = 3.0
        addButtonBox.layer.shadowOpacity = 0.5
        addButtonBox.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
