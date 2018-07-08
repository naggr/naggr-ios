//
//  ContactsHelper.swift
//  naggr
//
//  Created by Jonathan Moallem on 8/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI

class ContactsHelper: NSObject, CNContactPickerDelegate {
    
    // Data fields
    var contactStore = CNContactStore()
    let contactPicker = CNContactPickerViewController()
    var delegate: ContactsHelperDelegate?
    
    func askForContactAccess(in viewController: UIViewController) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        DispatchQueue.main.async {
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
                            }
                            
                            alertController.addAction(dismissAction)
                            
                            viewController.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
            break
        default:
            break
        }
    }
    
    func openPicker(in viewController: UIViewController) {
        contactPicker.delegate = self
        viewController.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            delegate?.onContactSelected(name: fullName, number: phoneNumber)
        }
        else {
            print("no phone number")
        }
    }
}

protocol ContactsHelperDelegate {
    func onContactSelected(name: String, number: String)
}
