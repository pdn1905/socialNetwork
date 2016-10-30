//
//  DataService.swift
//  socialNetwork
//
//  Created by Ngoc Duong Phan on 10/25/16.
//  Copyright © 2016 Ngoc Duong Phan. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    // database refenrence
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    // Storage Reference
    private var _REF_POST_IMAGES = STORAGE_BASE.child("posts-pic")
    
    
    
    var REF_BASE : FIRDatabaseReference {
    return _REF_BASE
    }
    
    var REF_POSTS : FIRDatabaseReference {
    return _REF_POSTS
    }
    
    var REF_USERS : FIRDatabaseReference {
    return _REF_USERS
    }
    
    var REF_POST_IMAGES : FIRStorageReference {
    return _REF_POST_IMAGES
    }
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,String>) {
    REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
