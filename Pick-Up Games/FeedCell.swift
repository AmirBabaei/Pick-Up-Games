//
//  FeedCell.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher

class FeedCell: UITableViewCell {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var sportType: UILabel!
    @IBOutlet weak var players: UILabel!
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    func fillCell(profPicURL: String, address: String, sport: String, playerCount: String, timeDate: String, name: String, distance: CLLocationDistance) {
        if (profPicURL != "") {
            let url = URL(string: profPicURL)
            self.profPic.kf.setImage(with: url)
            self.profPic.roundIt()
            self.profPic.contentMode = .scaleAspectFill
        } else {
            self.profPic.image = UIImage(named: "test-login")
            self.profPic.roundIt()
        }
        self.address.text = address
        self.sportType.text = sport
        self.players.text = playerCount
        self.uName.text = name
        self.timeDate.text = timeDate
        self.distance.text = "\((round(10*(distance * 0.000621371192))/10)) mil"
    }
}
