//
//  ProfileBioSubPage.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/9/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileBioSubPage: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var Interests: UILabel!
    @IBOutlet weak var Bio: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getBioInfo()
    }
}

extension ProfileBioSubPage {
    func getBioInfo() {
        let sharedID = SharedUID()
        let myID = sharedID.sharedInstance.UID
        print(myID)
        let REF_PROF = Database.database().reference().child("users").child(myID)
        REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
            self.Interests.text = profUserSnapshot.childSnapshot(forPath: "Interests").value as? String
            self.Bio.text = profUserSnapshot.childSnapshot(forPath: "Bio").value as? String
        }
    }
}

