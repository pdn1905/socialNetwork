//
//  CirceView.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/25/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    override func layoutSubviews() {
       
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
