//
//  EventView.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 11/23/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit

class EventView: UIViewController {
  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var userId: UILabel!
  @IBOutlet weak var sport: UILabel!
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var timeDate: UILabel!
  @IBOutlet weak var descript: UILabel!
  
  
  
  var imgs = UIImage()
   var userIDs = ""
   var sports = ""
   var addresss = ""
   var timeDates = ""
   var descripts = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
     img.image = imgs
     userId.text = userIDs
     sport.text = sports
     address.text = addresss
     timeDate.text = timeDates
     descript.text = descripts
    
  }
  



}
