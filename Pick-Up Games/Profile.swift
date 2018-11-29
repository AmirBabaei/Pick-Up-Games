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
    
    @IBAction func button(_ sender: Any) {
        let logout = Auth.auth()
        
        do {
            try logout.signOut()
        } catch let signOutError as NSError {
            print("Critical Error: Logout failed with error ", signOutError)
        }
        
        UserDefaults.standard.set(nil, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        print("User has logged out")
        self.performSegue(withIdentifier: "Logout", sender: self)
        
    }
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    @IBAction func AddFriends(_ sender: Any) {
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addFriends = vc.instantiateViewController(withIdentifier: "ProfileAddFriends") as! ProfileAddFriends
        
        navigationController?.pushViewController(addFriends, animated: true)
    }
    
    @IBAction func EditProfile(_ sender: Any) {
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfile = vc.instantiateViewController(withIdentifier: "ProfileEdit") as! ProfileEdit
        
        navigationController?.pushViewController(editProfile, animated: true)
    }
    
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
