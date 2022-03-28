//
//  ViewController.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 11.10.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rootRef = FIRDatabase.database().reference()        
        let itemsRef = rootRef.child("")   
        let milkRef = itemsRef.child("")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

