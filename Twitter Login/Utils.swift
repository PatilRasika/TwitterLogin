//
//  Utils.swift
//  Twitter Login
//
//  Created by Akshay Kadam on 22/09/18.
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import Foundation



static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.Alert);
    vc.presentViewController(alert, animated: true, completion: nil)
}