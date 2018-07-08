//
//  HomeViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 8/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController, NagPagerViewControllerDelegate, ContactsHelperDelegate {
    
    // Data fields
    let contactsHelper = ContactsHelper()
    let storageManager = StorageManager()
    var nags: [Nag] = [Nag]()
    
    // UI fields
    var pagerViewController: NagPagerViewController?

    // Outlet fields
    @IBOutlet weak var addButtonBox: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the view
        styleView()
        
        // Set up the contacts helper and ask for permissions
        contactsHelper.delegate = self
        contactsHelper.askForContactAccess(in: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? NagPagerViewController {
            // Get the pager reference and set the delegate
            viewController.pagerDelegate = self
            pagerViewController = viewController
            
            // Update the pager content
            fetchAndSetNags()
        }
    }
    
    private func fetchNags() throws -> [Nag] {
        // Fetch the nags from storage
        return try storageManager.loadNags()
    }
    
    func fetchAndSetNags() {
        // Fetch the nags
        do {
            nags = try fetchNags()
        }
        catch {
            print("an error happened")
        }
        // Set the nags
        pagerViewController?.set(nags: nags)
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        // Open the contact picker
        contactsHelper.openPicker(in: self)
    }
    
    func onPageCountChange(count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onPageIndexChange(index: Int) {
        pageControl.currentPage = index
    }
    
    func onContactSelected(name: String, number: String) {
        // Create the nag and add it to the list
        let nag = Nag(name: name, number: number, lastCalled: Date())
        nags.append(nag)
        
        // Persist the nag
        do {
            try storageManager.save(nags: nags)
        }
        catch {
            print("an error happened")
        }
        
        // Update the pager content
        pagerViewController?.set(nags: nags)
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
