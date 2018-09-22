//
//  FollwerViewController.swift
//  Twitter Login
//
//  Created by Rasika Patil
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import UIKit

class FollwerViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    var follwerArray = [[String: AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false
        
        // Do any additional setup after loading the view.
        self.tableView.reloadData()
        
        tableView.contentInset.top = 20
        tableView = UITableView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerNib(UINib(nibName: LISTTABLECELL, bundle: nil), forCellReuseIdentifier: LIST_TABLE_IDENTIFIER)
        view.addSubview(tableView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    // MARK: - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follwerArray.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 61
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(LIST_TABLE_IDENTIFIER) as! ListTableCellTableViewCell
        let friendList = follwerArray[indexPath.row]
        cell.button.tag = indexPath.row
        cell.button.image = friendList[PROFILE_IMG_KEY]! as? UIImage
        cell.button.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hdFullScreen))
        cell.button.addGestureRecognizer(tap)
        cell.name.text = friendList[SCREEN_NAME_KEY]! as? String
        
        
        return cell
    }
    
    // MARK: - Methods
    
    func hdFullScreen(sender: UITapGestureRecognizer){
        let index = sender.view?.tag
        let backView = UIView()
        let friendList = follwerArray[index!]
        let imageView = UIImageView(image: friendList[PROFILE_IMG_KEY]! as? UIImage)
        imageView.frame = CGRect(x:100, y: 260, width:240, height:240)
        imageView.backgroundColor = UIColor.blackColor()
        imageView.alpha = 1.0
        imageView.contentMode = .ScaleToFill
        imageView.userInteractionEnabled = true
        backView.frame = self.view.frame
        backView.backgroundColor = UIColor.blackColor()
       // backView.alpha = 0.10
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        backView.addGestureRecognizer(tap)
        backView.addSubview(imageView)
//        imageView.sendSubviewToBack(backView)
        self.view.addSubview(backView)
        
        
    }
    
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    func convertUrlToImage(imageString:String) -> UIImage{
        let url = NSURL(string: imageString)
        let data = try? NSData(contentsOfURL: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData!)
            return image!
        }
        
    }
    

}
