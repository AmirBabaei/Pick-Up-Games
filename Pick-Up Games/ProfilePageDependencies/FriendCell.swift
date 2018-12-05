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
    
    
    func fillCell(profPicURL: String, name: String) {
      profPic.roundIt()
      profPic.contentMode = .scaleAspectFill
      if (profPicURL != "") {
            let url = URL(string: profPicURL)
            self.profPic.kf.setImage(with: url)
        } else {
            self.profPic.image = UIImage(named: "test-login")
        }
        self.name.text = name
        
    }
}
