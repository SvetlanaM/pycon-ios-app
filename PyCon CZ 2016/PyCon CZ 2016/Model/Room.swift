//
//  Room.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 12.11.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Room : NSObject {
    let key : String?
    let ref : FIRDatabaseReference?
    var roomName : String?
    
    init(key : String, roomName : String) {
        self.key = key
        self.roomName = roomName
        self.ref = nil
    }
    
    init(snapshot : FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let name = snapshot.value!["rooms"] as? String {
            roomName = name
        }
    }
    
}
