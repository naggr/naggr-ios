//
//  NagViewController.swift
//  naggr
//
//  Created by Jonathan Moallem on 7/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import UIKit

class NagViewController: UIViewController {
    
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
    
    private func styleView() {
        // Image styling
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true;
        profileImage.layer.borderWidth = 7.0;
        profileImage.layer.borderColor = UIColor.white.cgColor;
        
        // Quote styling
        quoteBox.layer.cornerRadius = 5.0
        
        // Round button boxes
        callButtonBox.layer.cornerRadius = 5.0
        contactedButtonBox.layer.cornerRadius = 5.0
        removeButtonBox.layer.cornerRadius = 5.0
    }

}
