//
//  BaseService.swift
//  LogInApplication
//
//  Created by Henry Aguinaga on 2016-04-13.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = ""
let FIREBASE_REF = Firebase(url: "https://testapp-henry-aguinaga.firebaseio.com")

var CURRENT_USER: Firebase
{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    return currentUser!

}
