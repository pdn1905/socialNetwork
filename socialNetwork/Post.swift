//
//  Post.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/25/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import Foundation


class Post{
    
    
    private var _caption: String!
    private var _keyPost :String!
    private var _likes: Int!
    private var _imageURL :String!
    
    var caption :String {
    return _caption
    }
    
    var keyPost :String {
    return _keyPost
    }
    
    var likes : Int {
    return _likes
    }
    
    var imageURL :String {
    return _imageURL
    }
    
    init(caption: String,imageUrl: String, likes : Int) {
        self._caption = caption
        self._imageURL = imageUrl
        self._likes = likes
    }
    
    init(keyPost: String,dataPost: Dictionary<String,Any>) {
        self._keyPost = keyPost
        
        if let caption = dataPost["caption"] as? String{
        self._caption = caption
        }
        
        if let imageURL = dataPost["imageURL"] as? String {
        self._imageURL = imageURL
        }
        
        if let likes = dataPost["likes"] as? Int {
        self._likes = likes
        }
    }
}
