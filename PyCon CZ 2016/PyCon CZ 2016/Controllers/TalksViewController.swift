//
//  TalksViewController.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 15.10.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Social

class TalksViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var ref : FIRDatabaseReference!
    var talks = [Talk]()
    var collection : UICollectionView?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference().child("d105")
        checkDate("d105")
        startObservingDB()
        
        // Layout setup
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 170, right: 0)
        self.collection = UICollectionView(frame: CGRectMake(0, 80, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.collection!.registerClass(TalkCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collection!)
        self.collection?.backgroundColor = UIColor(red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1.0)
        
        
    
    }
    
    @IBAction func shareOnTwitter(sender: UIBarButtonItem) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("@pyconcz")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeRoom(sender: AnyObject) {
        if (segmentControl.selectedSegmentIndex == 0) {
            ref = FIRDatabase.database().reference().child("d105")
            checkDate("d105")
            startObservingDB()
        } else if (segmentControl.selectedSegmentIndex == 1) {
            ref = FIRDatabase.database().reference().child("d0206")
            checkDate("d0206")
            startObservingDB()
        } else if (segmentControl.selectedSegmentIndex == 2) {
            ref = FIRDatabase.database().reference().child("d0207")
            checkDate("d0207")
            startObservingDB()
        } else if (segmentControl.selectedSegmentIndex == 3) {
            ref = FIRDatabase.database().reference().child("a112")
            checkDate("a112")
            startObservingDB()
        } else if (segmentControl.selectedSegmentIndex == 4) {
            ref = FIRDatabase.database().reference().child("a113")
            checkDate("a113")
            startObservingDB()
        }
        
    }
    
    
    
    // collection view cell setup
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? TalkCollectionViewCell
        cell?.backgroundColor = .whiteColor()

        cell!.layer.cornerRadius = 10
        cell!.contentView.layer.cornerRadius = 2.0;
        cell!.contentView.layer.borderWidth = 1.0;
        cell!.contentView.layer.borderColor = UIColor.clearColor().CGColor;
        cell!.contentView.layer.masksToBounds = true;
        
        cell!.layer.shadowColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0).CGColor
        cell!.layer.shadowOffset = CGSizeMake(0, 4.0);
        cell!.layer.shadowRadius = 5.0;
        cell!.layer.shadowOpacity = 1.0;
        cell!.layer.masksToBounds = false;
        cell!.layer.shadowPath = UIBezierPath(roundedRect:cell!.bounds, cornerRadius:cell!.contentView.layer.cornerRadius).CGPath;
        // configure the cell
        
        
        
        cell?.configureCell(talks[indexPath.row])
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return talks.count
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section : Int) -> CGFloat {
        return 20.5
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section : Int) -> CGFloat {
        return 20.5
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-50, height: 120)
    }
    
    // add detail view on didselect
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = TalkDetailViewController()
        vc.talk = talks[indexPath.row]
        self.navigationController?.showViewController(vc, sender: self)
        }
    
    
    func checkDate(room : String) {
        let date = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(date)
        
        
        for talk in talks {
            let talkDate = talk.startDate! + " " + talk.endTime!
            if DateInFormat == talkDate {
                ref.child("\(room)/\(talk.key)/active").setValue(false)
            }
        }
    }
    
    func startObservingDB() {
        ref.observeEventType(.Value, withBlock: {( snapshot:FIRDataSnapshot) in
            
            var newTalks = [Talk]()
            self.talks = []
            
            for talk in snapshot.children {
                let talkObject = Talk(snapshot: talk as! FIRDataSnapshot)
                newTalks.append(talkObject)
            }
            
            for talk in newTalks {
                
                if talk.active == true {
                   self.talks.append(talk)
                }
            }
            
            self.collection?.reloadData()
            
        }) {(error : NSError) in
            print(error.description)
        }
    }
    
    
    
    
    

}
