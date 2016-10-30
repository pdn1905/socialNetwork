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

class FeedVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var posts = [Post]()
    var imagePicker : UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonLogOut(_ sender: AnyObject) {
       let keychainResult = KeychainWrapper.removeObjectForKey(UID_KEYCHAIN)
        print("UNINO: ID remove from keychain\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        
        performSegue(withIdentifier: "gotoLogin", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        //picker Image
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        DataService.ds.REF_POSTS.observe(.value, with: {snapshot in
            if let snapsho = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapsho {
                print("SNAPP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String,Any> {
                    let key = snap.key
                        let post = Post(keyPost: key, dataPost: postDict)
                        self.posts.append(post)
                    }
                }
            
            }
        self.tableView.reloadData()
        })
    }
    @IBOutlet weak var imageAdd: UIImageView!
    
    // picker image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
        imageAdd.image = image
        } else {
        print("JESS: a valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageButton(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
}

extension FeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PostCell {
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString) {
            cell.cofigureCell(post: post, img: img)
                return cell
            } else {
            cell.cofigureCell(post: post)
                return cell
            }
        
        } else {
        return PostCell()
        }
    }
}
