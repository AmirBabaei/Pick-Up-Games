//
//  FriendCell.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    func fillCell(profPic: UIImage, name: String) {
        self.profPic.image = profPic
        self.name.text = name
        
    }
}
