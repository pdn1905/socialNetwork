//
//  PostCell.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/25/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    func cofigureCell(post : Post){
    self.captionLabel.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
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
