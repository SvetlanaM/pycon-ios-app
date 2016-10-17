//
//  TwitterViewController.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 17.10.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: TWTRTimelineViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
        let client = TWTRAPIClient()
        

    }
    
    convenience init() {
        let client = TWTRAPIClient()
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: "#pyconcz", APIClient: client)
        self.init(dataSource: dataSource)

        
        
        // Show Tweet actions
        self.showTweetActions = true
    }


}
