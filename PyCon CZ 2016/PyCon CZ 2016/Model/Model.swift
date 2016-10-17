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

class Talk : NSObject {
    
    let key : String
    var title : String
    var avatar : String?
    var bio : String?
    var talkDescription: String?
    var endTime : String?
    var endDate : String?
    var github : String?
    var speaker : String?
    var startTime : String?
    var startDate : String?
    var twitter : String?
    var votes = [Int]()
    var type : String?
    var active : Bool?
    
    
    let ref : FIRDatabaseReference?
    
    init(key : String, title : String, avatar : String, bio : String, talkDescription : String, endTime : String, endDate : String, github : String, speaker : String, startTime : String, startDate : String, twitter : String, type : String) {
        self.key = key
        self.title = title
        self.avatar = avatar
        self.bio = bio
        self.talkDescription = talkDescription
        self.endDate = endDate
        self.endTime = endTime
        self.github = github
        self.startDate = startDate
        self.startTime = startTime
        self.twitter = twitter
        self.ref = nil
        self.speaker = speaker
        self.type = type
    }
    
    init(snapshot : FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let talktTitle = snapshot.value!["title"] as? String {
            
            if talktTitle == "" {
                title = snapshot.value!["description"] as? String ?? ""
            } else {
                title = talktTitle
            }
        } else {
            title = ""
        }
        
        if let speakerAvatar = snapshot.value!["avatar"] as? String {
            avatar = speakerAvatar
        } else {
            avatar = ""
        }
        
        if let speakerBio = snapshot.value!["bio"] as? String {
            bio = speakerBio
        } else {
            bio = ""
        }
        
        if let description = snapshot.value!["description"] as? String {
            talkDescription = description
        } else {
            talkDescription = ""
        }
        
        if let speakerGithub = snapshot.value!["github"] as? String {
            github = speakerGithub
        } else {
            github = ""
        }
        
        if let speakerTwitter = snapshot.value!["twitter"] as? String {
            twitter = speakerTwitter
        } else {
            twitter = ""
        }
        
        if let speakerName = snapshot.value!["speaker"] as? String {
            speaker = speakerName
        } else {
            speaker = ""
        }
        
        if let talkStartTime = snapshot.value!["start_time"] as? String {
            startTime = talkStartTime
        } else {
            startTime = ""
        }
        
        if let talkEndTime = snapshot.value!["end_time"] as? String {
            endTime = talkEndTime
        } else {
            endTime = ""
        }
        
        if let talkStartDate = snapshot.value!["start_date"] as? String {
            
            if talkStartDate == "28.10.2016" {
                startDate = "FRI"
            } else if talkStartDate == "29.10.2016" {
                startDate = "SAT"
            } else if talkStartDate == "30.10.2016" {
                startDate = "SUN"
            }
        } else {
            startDate = ""
        }
        
        if let talkType = snapshot.value!["type"] as? String {
            type = talkType
        } else {
            type = ""
        }
        
        if let isActive = snapshot.value!["active"] as? Bool {
            active = isActive
        } else {
            active = true
        }

        
        
    }
    

}