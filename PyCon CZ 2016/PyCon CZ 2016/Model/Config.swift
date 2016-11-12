//
//  Config.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 12.11.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Config : NSObject {
    let key : String
    let ref : FIRDatabaseReference?
    let active = True
    var facebook : String?
    var twitter : String?
    var pyconName : String?
    var pyconColor : UIColor
    
    init(key : String, facebook : String, twitter : String, pyconName : String, pyconColor: UIColor) {
        self.key = key
        self.facebook = facebook
        self.twitter = twitter
        self.pyconName = pyconName
        self.pyconColor = pyconColor
        self.ref = nil
    }
    
    init(snapshopt : FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let isActive = snapshot.value!["active"] as? Bool {
            active = isActive
        } else {
            active = True
        }
        
        if let fbName = snapshot.value!["facebook_mention"] as? String {
            facebook = fbName
        } else {
            facebook = ""
        }
        
        if let twName = snapshot.value!["twitter_hashtag"] as? String {
            twitter = twName
        } else {
            twitter = ""
        }
        
        if let pyName = snapshot.value!["pycon_db"] as? String {
            pyconName = pyName
        } else {
            pyconName = ""
        }
        
        if let color = snapshot.value!["pycon_color"] as? String {
            pyconColor = UIColor()
        } else {
            pyconColor = UIColor(red: 12/255.0, green: 13/255.0, blue: 15/255.0, alpha: 1.0)
        }
        
        
    }
}
