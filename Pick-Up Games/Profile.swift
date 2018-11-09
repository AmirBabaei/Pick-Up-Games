//
//  Profile.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/7/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class Profile: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getBasicInfo()
    }
}

extension Profile {
    func getBasicInfo() {
        let userID = Auth.auth().currentUser?.uid
        let REF_PROF = Database.database().reference().child("users").child(userID!)
        REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
            self.Username.text = profUserSnapshot.childSnapshot(forPath: "username").value as? String
            self.Name.text = profUserSnapshot.childSnapshot(forPath: "Full Name").value as? String
            self.Email.text = Auth.auth().currentUser?.email
            self.Age.text = profUserSnapshot.childSnapshot(forPath: "Age").value as? String
        }
    }
}
