//
//  UserViewControllerViewController.swift
//  Twitter Login
//
//  Created by Rasika Patil
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import UIKit
import TwitterKit
import Foundation
import Twitter

class UserViewControllerViewController: UIViewController {

    
    let friendController = FriendListViewController()
    let followersController = FollwerViewController()
    
    @IBOutlet weak var userBackgroundImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var descriptionUser: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    
    var  email :String?
    var name :String?
    var imageUrlValue : String?
    var userId:String?
    var friends = NSArray()
    var indicator = UIActivityIndicatorView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        
        userEmail.text = email
        userName.text = name
        
        userProfile.image = convertUrlToImage(imageUrlValue!)
        
        
        activityIndicator()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewControllerViewController.userInfoData(_:)), name:"UserInfoNotification", object: nil)
        AppInterface.shared.getUserInfo()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
         navigationController?.navigationBarHidden = true
    }
    
    func convertUrlToImage(imageString:String) -> UIImage{
        let url = NSURL(string: imageString)
        let data = try? NSData(contentsOfURL: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData!)
            return image!
        }
        
    }
    
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    
    //MARK:- NSNotification Methods
    
    func userInfoData(_notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: USERINFORMATION_NOTIFICATION, object: nil)
         if let dict = _notification.userInfo,let success = dict[SUCCESS] as? Bool{
                if success == true {
                if let userInfoDict = dict[USER_INFORMATION]{
                        var followersCount:AnyObject?
                        followersCount = userInfoDict[FOLLOWERS_COUNT] as AnyObject?
                        if let value = followersCount
                        {
                            let followerCounts:String = String(format: "%@", value as! NSNumber)
                            self.followersCount.text = followerCounts
                        }
                        
                        var friendsCount:AnyObject?
                        friendsCount = userInfoDict[FRIENDS_COUNT] as AnyObject?
                        if let value = friendsCount
                        {
                            let friendsCount:String = String(format: "%@", value as! NSNumber)
                            self.friendsCount.text = friendsCount
                        }
                    
                        if userInfoDict[DESCRIPTION] as? String == "" {
                            self.descriptionUser.text = NO_USER_DESCRIPTION
                        }
                        else{
                         self.descriptionUser.text = userInfoDict[DESCRIPTION] as? String
                        }
                    
                        let imageUrl = NSURL(string: (userInfoDict[USER_PROFILE_BACKGROUND_IMG] as? String)!)!
                        
                        let imageData = try! NSData(contentsOfURL: imageUrl)
                        
                        let image = UIImage(data: imageData!)
                        
                        self.userBackgroundImage.image = image
                    }
            }
            else
            {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                showAlertMessage(ERROR, controller:self)
            }
        }
    }
    
    
    func followerListData(_notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: FOLLOWERS_NOTIFICATION, object: nil)
            if let dict = _notification.userInfo,let success = dict[SUCCESS] as? Bool{
                if success == true {
                let followerDict = dict[USER_INFORMATION]
                self.followersController.follwerArray = followerDict as! [[String : AnyObject]]
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.navigationController?.pushViewController(self.followersController, animated: true)
            }
            else
            {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                showAlertMessage(ERROR, controller:self)
            }
        }
    }
    
    func friendListData(_notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: FRIENDS_NOTIFICATION, object: nil)
        if let dict = _notification.userInfo,let success = dict[SUCCESS] as? Bool{
            if success == true {
                let friendDict = dict[USER_INFORMATION]
                self.friendController.friendArray = friendDict as! [[String : AnyObject]]
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.navigationController?.pushViewController(self.friendController, animated: true)
            }
            else
            {
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                    showAlertMessage(ERROR, controller:self)
            }
        }
        
    }
    
    
    //MARK:- IBAction Methods
    
    @IBAction func followerTable(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            self.indicator.startAnimating()
        })
        
        indicator.color = UIColor.blueColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewControllerViewController.followerListData(_:)), name:FOLLOWERS_NOTIFICATION, object: nil)
        
        AppInterface.shared.getFollowersList()
    }
    
    @IBAction func friendTable(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            self.indicator.startAnimating()
        })
        indicator.color = UIColor.blueColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewControllerViewController.friendListData(_:)), name:FRIENDS_NOTIFICATION, object: nil)
        
        AppInterface.shared.getFriendList()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
