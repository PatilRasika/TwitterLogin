//
//  Constants.swift
//  Twitter Login
//
//  Created by Akshay Kadam on 22/09/18.
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import Foundation
import UIKit

//LOGIN

let ALERT = "Alert"
let OKAY = "OK"

//UserView

let USERINFORMATION_NOTIFICATION = "UserInfoNotification"
let USER_INFORMATION = "User_Information"
let FOLLOWERS_COUNT = "followers_count"
let FRIENDS_COUNT = "friends_count"
let DESCRIPTION = "description"
let USER_PROFILE_BACKGROUND_IMG = "profile_background_image_url_https"
let FOLLOWERS_NOTIFICATION = "FollowersListNotification"
let FRIENDS_NOTIFICATION = "FriendListNotification"
let NO_USER_DESCRIPTION = "User description not provided by user"

//AppInterface

let GET = "GET"
let USER_INFO_API = "https://api.twitter.com/1.1/users/show.json?cursor=-1&count=5000"
let USER_ID = "user_id"
let FRIEND_INFO_API = "https://api.twitter.com/1.1/friends/list.json?cursor=-1&count=5000"
let USERS = "users"
let USER_PROFILE_IMG = "profile_image_url_https"
let SCREEN_NAME_KEY = "screen_name"
let PROFILE_IMG_KEY = "profile_image_url"
let FOLLOWERS_INFO_API = "https://api.twitter.com/1.1/followers/list.json?cursor=-1&count=5000"
let SUCCESS = "Success"
let ERROR = "The Internet connection appears to be offline."



//TableCell

let LISTTABLECELL = "ListTableCellTableViewCell"
let LIST_TABLE_IDENTIFIER = "ListTable"


func showAlertMessage(message:String, controller:UIViewController) {
    let alert = UIAlertController(title: ALERT, message:message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: OKAY, style: UIAlertActionStyle.Default, handler: nil))
    controller.presentViewController(alert, animated: true, completion: nil)
}
