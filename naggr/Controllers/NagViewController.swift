//
//  NagViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 7/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit

class NagViewController: UIViewController {
    
    // Data fields
    var nag: Nag?

    // Outlet fields
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteBox: UIView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var callButtonBox: UIView!
    @IBOutlet weak var contactedButtonBox: UIView!
    @IBOutlet weak var removeButtonBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the styling
        styleView()
        
        // Set values for the Nag
        nameLabel.text = nag?.name
        quoteLabel.text = "You haven't called me in a few days now... don't you love me anymore?"
    }
    
    @available(iOS 10.0, *)
    @IBAction func onCallClicked(_ sender: Any) {
        var formattedNumber = nag!.number.replacingOccurrences(of: "-", with: "")
        formattedNumber = formattedNumber.replacingOccurrences(of: " ", with: "")
        print(formattedNumber)
        
        if let url = NSURL(string: "tel://\(formattedNumber)") {
            UIApplication.shared.openURL(url as URL)
        }
        else {
            print("url is nil")
        }
        
        onContactedClicked(self)
    }
    
    @IBAction func onContactedClicked(_ sender: Any) {
        let storageManager = StorageManager()
        
        do {
            var nags: [Nag] = try getNags(for: storageManager)
            for i in 0 ..< nags.count {
                nags[i].lastCalled = Date()
            }
            try commit(nags: nags, for: storageManager)
        }
        catch {
            print("there was an error")
        }
    }
    
    @IBAction func onDeleteClicked(_ sender: Any) {
        let storageManager = StorageManager()
        
        do {
            var nags: [Nag] = try getNags(for: storageManager)
            nags = nags.filter() { $0.number != nag?.number }
            try commit(nags: nags, for: storageManager)
        }
        catch {
            print("there was an error")
        }
    }
    
    private func getNags(for manager: StorageManager) throws -> [Nag] {
        return try manager.loadNags()
    }
    
    private func commit(nags: [Nag], for manager: StorageManager) throws {
        try manager.save(nags: nags)
    }
    
    private func styleView() {
        // Image styling
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 7.0
        profileImage.contentMode = .scaleAspectFill
        
        // Quote styling
        quoteBox.layer.cornerRadius = 5.0
        
        // Round button boxes
        callButtonBox.layer.cornerRadius = 5.0
        contactedButtonBox.layer.cornerRadius = 5.0
        removeButtonBox.layer.cornerRadius = 5.0
    }
}
