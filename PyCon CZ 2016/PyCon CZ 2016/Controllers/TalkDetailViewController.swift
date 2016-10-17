//
//  TalkDetailViewController.swift
//  PyCon CZ 2016
//
//  Created by Svetlana Margetová on 16.10.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//
import Social
import UIKit

class TalkDetailViewController: UIViewController {

    var contentView : UIView?
    var textView : UIView?
    var scrollView : UIScrollView?
    
    var date : UILabel!
    var talkTitle : UILabel!
    var speakerLabel : UILabel!
    var imageV : UIImageView?
    var talkDescLabel : UILabel!
    var showDetailLabel : UILabel!
    var talk : Talk?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = talk?.title
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        var twitterButton : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "twitter"), style: UIBarButtonItemStyle.Plain, target: self, action: "sendTwitter:")
        self.navigationItem.rightBarButtonItem = twitterButton
        
        
        // View setup
        self.view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.view!.backgroundColor = UIColor(red: 247/255.0, green: 249/255.0, blue: 252/255.0, alpha: 1.0)
        
        // Image setup
        self.imageV = UIImageView(frame : CGRectMake(0, (self.view.frame.height) - 250, self.view.frame.width, 200))
        self.imageV?.image = UIImage(named: "pycon_overlay")
        self.imageV?.contentMode = .ScaleAspectFill
        self.imageV?.clipsToBounds = true
        self.view!.addSubview(imageV!)
        
        // Text view setup
        self.textView = UIView(frame: CGRectMake(30, 40, self.view.frame.width-60, self.view.frame.height-150))
        self.textView!.backgroundColor = UIColor.whiteColor()
        self.textView!.layer.cornerRadius = 4.0;
        self.textView!.layer.borderWidth = 1.0;
        self.textView!.layer.borderColor = UIColor.clearColor().CGColor;
        self.textView!.layer.masksToBounds = true;
        
        self.textView!.layer.shadowColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0).CGColor
        self.textView!.layer.shadowOffset = CGSizeMake(0, 4.0);
        self.textView!.layer.shadowRadius = 5.0;
        self.textView!.layer.shadowOpacity = 1.0;
        self.textView!.layer.masksToBounds = false;
        self.textView!.layer.shadowPath = UIBezierPath(roundedRect:self.textView!.bounds, cornerRadius:self.textView!.layer.cornerRadius).CGPath
        self.view.addSubview(self.textView!)
        
        
        
        // Date setup
        let dateFrame = CGRectMake(0, 10, 80, 100)
        date = UILabel(frame: dateFrame)
        date.font = UIFont.boldSystemFontOfSize(18.0)
        date.textColor = .blackColor()
        date.backgroundColor = .whiteColor()
        date.textAlignment = .Center
        date.numberOfLines = 3
        let border = CALayer()
        border.backgroundColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0).CGColor
        border.frame = CGRect(x: 75, y: 0, width: 0.5, height: dateFrame.height)
        date.layer.addSublayer(border)
        date.lineBreakMode = .ByWordWrapping
        textView!.addSubview(date)
        
        // Title setup
        let titleFrame = CGRectMake(90, -50, (self.textView!.frame.width)-100, 200)
        talkTitle = UILabel(frame: titleFrame)
        talkTitle.textColor = .blackColor()
        talkTitle.textAlignment = .Left
        talkTitle.numberOfLines = 4
        textView!.addSubview(talkTitle)
        
        // Speaker name setup
        let speakerFrame = CGRectMake(90, -8, (self.textView!.frame.width)-100, 200)
        speakerLabel = UILabel(frame: speakerFrame)
        speakerLabel.font = UIFont.systemFontOfSize(14.0)
        speakerLabel.textColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0)
        speakerLabel.textAlignment = .Left
        speakerLabel.numberOfLines = 2
        speakerLabel.lineBreakMode = .ByWordWrapping
        textView!.addSubview(speakerLabel)
        
        // Description setup
        let showDetailFrame = CGRectMake(self.textView!.frame.width-90, -8, (self.textView!.frame.width)-100, 200)
        showDetailLabel = UILabel(frame: showDetailFrame)
        showDetailLabel.font = UIFont.systemFontOfSize(14.0)
        showDetailLabel.textColor = UIColor(red: 205/255.0, green: 209/255.0, blue: 213/255.0, alpha: 1.0)
        showDetailLabel.textAlignment = .Left
        showDetailLabel.numberOfLines = 1
        showDetailLabel.lineBreakMode = .ByWordWrapping
        self.textView!.addSubview(showDetailLabel)
        
        // Theme setup
        var talkDescFrame = heightForView((talk?.talkDescription!)!)
        talkDescLabel = UILabel(frame: talkDescFrame)
        talkDescLabel.font = UIFont.systemFontOfSize(16.0)
        talkDescLabel.textColor = UIColor.blackColor()
        talkDescLabel.textAlignment = .Left
        talkDescLabel.numberOfLines = 0
        talkDescLabel.lineBreakMode = .ByWordWrapping
        textView!.addSubview(talkDescLabel)
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view!.frame.width-60, self.textView!.frame.height))
        scrollView.addSubview(self.talkDescLabel)
        scrollView.addSubview(talkTitle)
        scrollView.addSubview(showDetailLabel)
        scrollView.addSubview(speakerLabel)
        scrollView.addSubview(date)
        scrollView.contentSize = CGSize(width: self.textView!.frame.width, height: self.textView!.frame.height + 190)
        self.textView!.addSubview(scrollView)
        
        date.text = talk!.startDate! + "\n" + talk!.startTime! + "\n" + talk!.endTime!
        talkTitle.text = talk?.title
        speakerLabel.text = talk?.speaker
        talkDescLabel.text = talk?.talkDescription
        showDetailLabel.text = "Show more"
        
    }
    
    func heightForView(text:String) -> CGRect {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.view!.frame.width-90, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.text = text
        label.font = UIFont.systemFontOfSize(16.0)
        label.sizeToFit()
        return CGRectMake(20, 120, self.view!.frame.width-90, label.frame.height)
        
    }
    
    func sendTwitter(sender : UIBarButtonItem) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("@pyconcz, " + talk!.twitter! ?? "@")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
   

    

}
