//
//  LoginViewController.swift
//  Twitter Login
//
//  Created by Rasika Patil
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    let userController = UserViewControllerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if session != nil{
                    if let userID = TWTRTwitter.sharedInstance().sessionStore.session()?.userID {
                    self.userController.userId = userID
                    let client = TWTRAPIClient(userID: userID)
                    client.loadUserWithID(userID, completion: {(user,error) in
                        
                        self.userController.name = session!.userName
                        self.userController.imageUrlValue = user?.profileImageURL
                      
                        client.requestEmailForCurrentUser({email, error in
                            if (email != nil) {
                                self.userController.email = email
                                self.navigationController?.pushViewController(self.userController, animated: true)
                                
                            } else {
                                
                                print("error: \(error!.localizedDescription)");
                            }
                        })
                    })
                    
                }
            }
            else
            {
                print("error: \(error!.localizedDescription)");
                showAlertMessage(error!.localizedDescription, controller: self)
                
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
