//
//  ViewController.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/22/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTag.layer.cornerRadius = 5
        
           }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(UID_KEYCHAIN) {
            performSegue(withIdentifier: "gotoFeed", sender: nil)
        }

    }

    @IBOutlet weak var loginTag: UIButton!
    @IBAction func loginTapped(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
    
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (results,error) in
            
            if error != nil {
            print("UNINU: Unable to authenticate with Facebook - \(error)")
                            }
            else if results?.isCancelled == true {
             print("UNINU: User cancelled Fb authentication")
            } else {
            print("UNINU: Succesfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            
            }
        }
        
        
    }
    
    // login email
    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailTextField.text, let pass = passTextField.text {
        FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
            if error == nil {
            print("UNINU: Email user authenticate with Firebase - \(error)")
                if let user = user {
                 self.completeLogIn(id: (user.uid))
                
                }
            }
            else {
            FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                if error != nil {
                print("UNINU: Unable authenticate with firebase using email \(error)")
                } else {
                print("UNINU: Succesfully authenticated with Emails")
                    if let user = user {
                    self.completeLogIn(id: (user.uid))
                    }
                   
                }
            })
            }
        })
            
        }
        
    }
    
    //login facebook
    func firebaseAuth(_ credential: FIRAuthCredential) {
    FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
        if error != nil {
        print("UNINU: Enable to authenticate with Firebase- \(error)")
           

        } else {
            if let user = user {
            self.completeLogIn(id: user.uid)
            }
        }
    })
    
    
    }
    
    func completeLogIn(id: String) {
       let keychainResult = KeychainWrapper.setString(id, forKey: UID_KEYCHAIN)
        print("UNINA: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "gotoFeed", sender: nil)
    }
    

}

