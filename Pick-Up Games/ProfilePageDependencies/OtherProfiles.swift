//
//  OtherProfiles.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/15/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class OtherProfiles: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    var UID:String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getBasicInfo()
    }
}

extension OtherProfiles {
    func getBasicInfo() {
        print(UID)
        let REF_PROF = Database.database().reference().child("users").child(UID)
        REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
            self.Username.text = profUserSnapshot.childSnapshot(forPath: "username").value as? String
            self.Name.text = profUserSnapshot.childSnapshot(forPath: "Full Name").value as? String
            self.Age.text = profUserSnapshot.childSnapshot(forPath: "Age").value as? String
        }
    }
}
