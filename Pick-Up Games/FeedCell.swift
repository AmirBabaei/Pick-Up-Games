//
//  FeedCell.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

  @IBOutlet var ProfPic: UIImageView!
  @IBOutlet var uName: UILabel!
  @IBOutlet var address: UILabel!
  @IBOutlet var sportType: UILabel!
  
  @IBOutlet var Players: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
