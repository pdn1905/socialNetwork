//
//  PostCell.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/25/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var post : Post!
    
    func cofigureCell(post : Post, img: UIImage? = nil){
        self.post = post
        self.captionLabel.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        
        if img != nil {
        self.postImage.image = img
        } else {
        let ref = FIRStorage.storage().reference(forURL: post.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                print("UMOMO: Unable dowload image")
                } else {
                print("UMOMO: Dowloaded image from Firebase Storage")
                    if let imageData = data {
                        if let img = UIImage(data: imageData){
                        self.postImage.image = img
                            FeedVC.imageCache.setObject(img,forKey: post.imageURL as NSString)
                        }
                    }
                }
                
            })
        }
    }
    
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = self.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
