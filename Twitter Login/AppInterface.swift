//
//  AppInterface.swift
//  Twitter Login
//
//  Created by Rasika Patil
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import UIKit
import TwitterKit


   let userID = TWTRTwitter.sharedInstance().sessionStore.session()?.userID
   let client = TWTRAPIClient(userID: userID)

final class AppInterface {
    //make sure only one instance is made
    static let shared = AppInterface()
    
    //Make sure no one uses default initializer
    private init() {
        
    }
    
    //MARK: API Calls
  
    func getUserInfo() {
        
        let request = client.URLRequestWithMethod(GET, URLString: USER_INFO_API, parameters: [USER_ID:TWTRTwitter.sharedInstance().sessionStore.session()!.userID], error: nil)
        
        
        client.sendTwitterRequest(request, completion: { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if response != nil{
            do
                {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(USERINFORMATION_NOTIFICATION, object:nil ,userInfo:[USER_INFORMATION:dict,SUCCESS:true])
                    })
                    
                }
                catch let error
                {
                    print(error)
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName(USERINFORMATION_NOTIFICATION, object:nil ,userInfo:[SUCCESS:false])
                })
            }
        })
        
    
    }
    
    
    func getFriendList() {

        let request = client.URLRequestWithMethod(GET, URLString: FRIEND_INFO_API, parameters: [USER_ID:userID!], error: nil)
        
        
        client.sendTwitterRequest(request, completion: { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if response != nil{
                do
                {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let friendsList = dict[USERS] as! NSArray
                    
                    var friendListArray = [[String: AnyObject]]()
                    for i in friendsList {
                        let image = UIImage(data: NSData(contentsOfURL: NSURL(string:i[USER_PROFILE_IMG] as! String)!)!)
                        let dict = [SCREEN_NAME_KEY: i[SCREEN_NAME_KEY], PROFILE_IMG_KEY: image]
                        
                        friendListArray.append(dict as! [String : AnyObject])
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(FRIENDS_NOTIFICATION, object:nil ,userInfo:[USER_INFORMATION:friendListArray,SUCCESS:true ])
                    })
                    
                }
                catch let error
                {
                    print(error)
                }
            }
            else
            {

                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName(FRIENDS_NOTIFICATION, object:nil ,userInfo:[SUCCESS:false])
                })
            }
        })
    }
    
    func getFollowersList() {
        
        let request = client.URLRequestWithMethod(GET, URLString: FOLLOWERS_INFO_API, parameters: [USER_ID:userID!], error: nil)
        
        
        client.sendTwitterRequest(request, completion: { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if response != nil{
                do
                {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let friendsList = dict[USERS] as! NSArray
                    
                    var followerListArray = [[String: AnyObject]]()
                    for i in friendsList {
                        let image = UIImage(data: NSData(contentsOfURL: NSURL(string:i[USER_PROFILE_IMG] as! String)!)!)
                        let dict = [SCREEN_NAME_KEY: i[SCREEN_NAME_KEY], PROFILE_IMG_KEY: image]
                        
                        followerListArray.append(dict as! [String : AnyObject])
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(FOLLOWERS_NOTIFICATION, object:nil ,userInfo:[USER_INFORMATION:followerListArray,SUCCESS:true])
                    })
                    
                }
                catch let error
                {
                    print(error)
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName(FOLLOWERS_NOTIFICATION, object:nil ,userInfo:[SUCCESS:false])
                })
            }
        })
    }
    
}