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

class DataManager {
    
    static let sharedInstance = DataManager()
    var ref : FIRDatabaseReference?
    var rooms = [Room]()
    var talks = [Talk]()
    
    let mainRef = FIRDatabase.database().reference()
    
    //editable pycon item
    
    
}
