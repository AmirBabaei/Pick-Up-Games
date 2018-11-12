//
//  ProfileEdit.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class ProfileEdit: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getBasicInfo()
    }
}

extension ProfileEdit {
    func getBasicInfo() {
        let userID = Auth.auth().currentUser?.uid
        let REF_PROF = Database.database().reference().child("users").child(userID!)
        
        ref.child("users").child((user?.user.uid)!).setValue(["username": self.UsernameTF.text!])
    }
}
