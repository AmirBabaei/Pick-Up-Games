//
//  FeedCell.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var sportType: UILabel!
    @IBOutlet weak var players: UILabel!
    @IBOutlet weak var uName: UILabel!
  
    func fillCell(profPic: UIImage, address: String, sport: String, playerCount: String, name: String) {
        self.profPic.image = profPic
        self.address.text = address
        self.sportType.text = sport
        self.players.text = playerCount
        self.uName.text = name
    }
}
