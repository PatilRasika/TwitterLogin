//
//  ListTableCellTableViewCell.swift
//  Twitter Login
//
//  Created by Rasika Patil
//  Copyright © 2018 Rasika Patil. All rights reserved.
//

import UIKit

class ListTableCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var button: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        button?.layer.cornerRadius = (button?.frame.size.width ?? 0.0) / 2
        button?.clipsToBounds = true
        button?.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
