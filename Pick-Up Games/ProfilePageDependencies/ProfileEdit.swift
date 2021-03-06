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
import FirebaseStorage
import Kingfisher




class ProfileEdit: UIViewController, UITextFieldDelegate {
  
  
  public var img1 = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Username.delegate = self
        setImage()
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
      
      view.addGestureRecognizer(tapGesture)
    }
  
 
  @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
    view.endEditing(true)
  }
  
  var selectedImage: UIImage?
  @IBOutlet weak var profilePic: UIImageView!
  @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Age: UITextField!
    @IBOutlet weak var Bio: UITextField!
    @IBOutlet weak var Interests: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //cickable image
      profilePic.roundIt()
      profilePic.contentMode = .scaleAspectFill
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileEdit.handleSelectImageView))
      profilePic.addGestureRecognizer(tapGesture)
      profilePic.isUserInteractionEnabled = true
      
    }
  func setImage(){
    let userID = Auth.auth().currentUser?.uid
    let REF_PROF = Database.database().reference().child("users").child(userID!)
    REF_PROF.observeSingleEvent(of: .value) { (profUserSnapshot) in
      self.Username.text = profUserSnapshot.childSnapshot(forPath: "username").value as? String
      self.Name.text = profUserSnapshot.childSnapshot(forPath: "Full Name").value as? String
      //self.Email.text = Auth.auth().currentUser?.email
      //self.Age.text = profUserSnapshot.childSnapshot(forPath: "Age").value as? String
      var imageURL = profUserSnapshot.childSnapshot(forPath: "ProfilePicURL").value as? String ?? ""
      let url = URL(string: imageURL)
      self.profilePic.kf.setImage(with: url)
      
    }
  }
  
  //picking photos
  @objc func handleSelectImageView(){
    
    let pickerControler = UIImagePickerController()
    pickerControler.delegate = self
    pickerControler.allowsEditing = false
    self.present(pickerControler, animated: true)
    present(pickerControler, animated: true, completion: nil)

  }

  
  
    @IBAction func DoneEditing(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let REF_PROF = Database.database().reference().child("users").child(userID!)
        
        if (self.Username.text != "Edit Username") {
            REF_PROF.child("username").setValue(self.Username.text!)
        }
        if (self.Name.text != "Edit Name") {
            REF_PROF.child("Full Name").setValue(self.Name.text!)
        }
        if (self.Age.text != "Edit Age") {
            REF_PROF.child("Age").setValue(self.Age.text!)
        }
        if (self.Bio.text != "Edit Bio") {
            REF_PROF.child("Bio").setValue(self.Bio.text!)
        }
        if (self.Interests.text != "Edit Interests") {
            REF_PROF.child("Interests").setValue(self.Interests.text!)
        }
      self.navigationController?.popViewController(animated: true)
      
  }
}




extension ProfileEdit: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    //print("did finish picking")
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      selectedImage = image
      profilePic.image = image
      
      let data = Data()
      //store the pictur
      let storage = Storage.storage()
      let storageRef = storage.reference(forURL: "gs://pick-up-games-e98cf.appspot.com")
      let imagesRef = storageRef.child("profilePics").child((Auth.auth().currentUser?.uid)!)
      let imageData = selectedImage!.jpegData(compressionQuality: 0.25)
      let uploadTask = imagesRef.putData(imageData!, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else {
          // Uh-oh, an error occurred!
          return
        }
        
        // Metadata contains file metadata such as size, content-type.
        let size = metadata.size
        // You can also access to download URL after upload.
        imagesRef.downloadURL { (url, error) in
          guard let downloadURL = url else {
            // Uh-oh, an error occurred!
            return
          }
          let urlString = url?.absoluteString
          let REF_PROF = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
          REF_PROF.child("ProfilePicURL").setValue(urlString)
            
            let REF_EVENTS = Database.database().reference().child("Event")
            REF_EVENTS.observeSingleEvent(of: .value) { (eventSnapshot) in
                guard let eventSnapshot = eventSnapshot.children.allObjects as? [DataSnapshot] else { return }
                
                for event in eventSnapshot {
                    if (event.childSnapshot(forPath: "EventCreator_UserID").value as! String == (Auth.auth().currentUser?.uid)!) {
                        REF_EVENTS.child(event.key).child("EventCreator_ProfPic").setValue(urlString)
                            
                    }
                }
            }
        }
      }
    }
    else{
      //error
    }
    dismiss(animated: true, completion: nil)
  }
}
