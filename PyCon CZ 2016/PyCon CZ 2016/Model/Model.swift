//
//  Model.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 14.10.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Room : NSObject {
    var rooms = [String]()
    let key : String
    
    init(key : String) {
        self.key = key
        self.ref = nil
    }
    
    let ref : FIRDatabaseReference?
    
    init(snapshot : FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
    
        if let roomArr = snapshot.value!["rooms"] as? [String]{
            self.rooms = roomArr
        }

    }
    
    
    
}
