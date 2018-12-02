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
import FirebaseStorage
import Kingfisher

class Profile: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func button(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        print("User has logged out")
        self.performSegue(withIdentifier: "Logout", sender: self)
        
    }
    
  @IBOutlet weak var profilePic: UIImageView!
  @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
  var imageUrl = ""
    
    @IBAction func AddFriends(_ sender: Any) {
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addFriends = vc.instantiateViewController(withIdentifier: "ProfileAddFriends") as! ProfileAddFriends
        
        navigationController?.pushViewController(addFriends, animated: true)
    }
    
    @IBAction func EditProfile(_ sender: Any) {
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfile = vc.instantiateViewController(withIdentifier: "ProfileEdit") as! ProfileEdit
      editProfile.img1 = profilePic.image!
        navigationController?.pushViewController(editProfile, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // getBasicInfo()
      setImage()
    }
  
  func setImage(){
    let userID = Auth.auth().currentUser?.uid
    let REF_PROF = Database.database().reference().child("users").child(userID!)
    REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
      self.Username.text = profUserSnapshot.childSnapshot(forPath: "username").value as? String
      self.Name.text = profUserSnapshot.childSnapshot(forPath: "Full Name").value as? String
      self.Email.text = Auth.auth().currentUser?.email
      //self.Age.text = profUserSnapshot.childSnapshot(forPath: "Age").value as? String
      self.imageUrl = profUserSnapshot.childSnapshot(forPath: "ProfilePicURL").value as? String ?? ""
      print("------------imageurl",self.imageUrl)
      let url = URL(string: self.imageUrl)
      self.profilePic.kf.setImage(with: url)
      
    }
    
    
    
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
      //download pic
      let storage = Storage.storage()
      let storageRef = storage.reference(forURL: "gs://pick-up-games-e98cf.appspot.com")
      let imagesRef = storageRef.child("profilePics").child(userID!)
      
      imagesRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if let error = error {
          // Uh-oh, an error occurred!
        
        } else {
          // Data for "images/island.jpg" is returned
          self.profilePic.image = UIImage(data: data!)
        }
      }
    }
}
