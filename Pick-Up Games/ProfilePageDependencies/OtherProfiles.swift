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
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    var UID = String()
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func AddFriend(_ sender: Any) {
        let myUserID = Auth.auth().currentUser?.uid
        let REF_MY_PROF = Database.database().reference().child("users").child(myUserID!)
        
        REF_MY_PROF.child("Friends/\(UID)").observeSingleEvent(of: .value, with: { (friendSnapshot) in
            if (!friendSnapshot.exists()) {
                REF_MY_PROF.child("Friends/\(self.UID)").setValue("")
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getBasicInfo()
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = vc.instantiateViewController(withIdentifier: "ProfileSubPages") as! ProfileSubPages
        vc2.UID = UID
    }
}

extension OtherProfiles {
    func getBasicInfo() {
        print(UID)
        let REF_PROF = Database.database().reference().child("users").child(UID)
        REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
            var imageURL = ""
            if (profUserSnapshot.childSnapshot(forPath: "ProfilePicURL").exists()) {
                imageURL = profUserSnapshot.childSnapshot(forPath: "ProfilePicURL").value as! String
            }
            if (imageURL != "") {
                let url = URL(string: imageURL)
                self.proprofilePicfPic.kf.setImage(with: url)
            } else {
                self.profilePic.image = UIImage(named: "test-login")
            }
            self.Username.text = profUserSnapshot.childSnapshot(forPath: "username").value as? String
            self.Name.text = profUserSnapshot.childSnapshot(forPath: "Full Name").value as? String
            self.Age.text = profUserSnapshot.childSnapshot(forPath: "Age").value as? String
        }
    }
}
