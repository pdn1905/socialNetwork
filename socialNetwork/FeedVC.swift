//
//  FeedVCViewController.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/23/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {
    
    
    @IBAction func button(_ sender: AnyObject) {
       let keychainResult = KeychainWrapper.removeObjectForKey(UID_KEYCHAIN)
        print("UNINO: ID remove from keychain\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        
        performSegue(withIdentifier: "gotoLogin", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
