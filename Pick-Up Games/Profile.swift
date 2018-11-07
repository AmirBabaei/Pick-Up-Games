//
//  Profile.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/7/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Profile: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    let REF_PROF = Database.database().reference().child("users")
    REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
        guard let feedEventSnapshot = feedEventSnapshot.children.allObjects as? [DataSnapshot] else { return }
    
        for pug in feedEventSnapshot {
            let address = pug.childSnapshot(forPath: "EventLocation").value as! String
            let sport = pug.childSnapshot(forPath: "EventType").value as! String
            let players = pug.childSnapshot(forPath: "EventParticipant_Limit").value as! String
            let name = pug.childSnapshot(forPath: "EventCreator_UserName").value as! String
            funcEventArray.append(pug)
        }
        handler(funcEventArray)
    }
}
