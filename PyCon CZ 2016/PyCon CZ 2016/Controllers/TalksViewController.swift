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
import SVProgressHUD

class TalksViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var ref : FIRDatabaseReference!
    
    var talks = [Talk]()
    var collection : UICollectionView?
    var infoLabel : UILabel?
    
    var rooms = [Room]()

    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        SVProgressHUD.show()
        
        let rootRef = FIRDatabase.database().reference()
        let itemsRef = rootRef.child("pyconcz2016")
        
        let roomsRef = itemsRef.child("rooms")
        
        print (roomsRef.key)
        
        
        
        
        delay(4) {
            if self.talks.isEmpty {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Network Error", message: "No data connection. Please connect via your data or via Wifi. But you still have offline access to your data.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                self.ref = FIRDatabase.database().reference().child("d105")
                
                self.startObservingDB()
                self.ref.keepSynced(true)
            }
        }
        
        
        
        let connectedRef = FIRDatabase.database().referenceWithPath(".info/connected")
        connectedRef.observeEventType(.Value, withBlock: { snapshot in
            if let connected = snapshot.value as? Bool where connected {
                if connected == true {
                    
                    self.changeRoom(UISegmentedControl)
                    
                     }
            } else {
                
                print ("")
                
            }
        })
        
        // Layout setup
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 170, right: 0)
        self.collection = UICollectionView(frame: CGRectMake(0, 80, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.collection?.registerClass(TalkCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collection!)
        self.collection?.backgroundColor = UIColor(red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1.0)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
        }
    
    @IBAction func shareOnTwitter(sender: UIBarButtonItem) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("#pyconcz")
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
            
            startObservingDB()
            ref.keepSynced(true)
        } else if (segmentControl.selectedSegmentIndex == 1) {
            SVProgressHUD.show()
            ref = FIRDatabase.database().reference().child("d0206")
            
            startObservingDB()
            ref.keepSynced(true)
        } else if (segmentControl.selectedSegmentIndex == 2) {
            SVProgressHUD.show()
            ref = FIRDatabase.database().reference().child("d0207")
            
            startObservingDB()
            ref.keepSynced(true)
        } else if (segmentControl.selectedSegmentIndex == 3) {
            ref = FIRDatabase.database().reference().child("a112")
            SVProgressHUD.show()
            
            startObservingDB()
            ref.keepSynced(true)
        } else if (segmentControl.selectedSegmentIndex == 4) {
            ref = FIRDatabase.database().reference().child("a113")
            SVProgressHUD.show()
            
            startObservingDB()
            ref.keepSynced(true)
        }
        
    }
    
    // collection view cell setup
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? TalkCollectionViewCell
        
        if let collCell = cell {
            collCell.backgroundColor = .whiteColor()
            collCell.layer.cornerRadius = 10
            collCell.contentView.layer.cornerRadius = 2.0;
            collCell.contentView.layer.borderWidth = 1.0;
            collCell.contentView.layer.borderColor = UIColor.clearColor().CGColor;
            collCell.contentView.layer.masksToBounds = true;
            collCell.layer.shadowColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0).CGColor
            collCell.layer.shadowOffset = CGSizeMake(0, 4.0);
            collCell.layer.shadowRadius = 5.0;
            collCell.layer.shadowOpacity = 1.0;
            collCell.layer.masksToBounds = false;
            collCell.layer.shadowPath = UIBezierPath(roundedRect:cell!.bounds, cornerRadius:cell!.contentView.layer.cornerRadius).CGPath;
            collCell.configureCell(talks[indexPath.row])
            return collCell
        } else {
            return UICollectionViewCell()
        }
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
            if talks[indexPath.row].type == "event" {
                cell?.selected = false
            } else {
                
                cell?.selected = true
                
                let vc = TalkDetailViewController()
                vc.talk = talks[indexPath.row]
                self.navigationController?.showViewController(vc, sender: self)
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
            
            if self.talks.isEmpty {
                SVProgressHUD.dismiss()
            }
            
            self.collection?.reloadData()
            SVProgressHUD.dismiss()
            
            
            
            
            

            
        }) {(error : NSError) in
            print(error.description)
        }
    }
    
    
    
    
    

}
