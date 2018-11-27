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


class ProfileEdit: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
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
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileEdit.handleSelectImageView))
      profilePic.addGestureRecognizer(tapGesture)
      profilePic.isUserInteractionEnabled = true
      
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
      let data = Data()
      //store the pictur
      let storage = Storage.storage()
      let storageRef = storage.reference(forURL: "gs://pick-up-games-e98cf.appspot.com")
      let imagesRef = storageRef.child("profilePics").child(userID!)
      let imageData = selectedImage!.jpegData(compressionQuality: 0.75)
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
          print("print URL \(url)")
        }
      }
      //imagesRef.putFile(from: , metadata: T##StorageMetadata?, completion: <#T##((StorageMetadata?, Error?) -> Void)?##((StorageMetadata?, Error?) -> Void)?##(StorageMetadata?, Error?) -> Void#>)
      //let storageRef = stor.storage().reference(forURL: "gs://pick-up-games-e98cf.appspot.com")
      //let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
       // guard let metadata = metadata else {
          // Uh-oh, an error occurred!
         // return
      }
  }




extension ProfileEdit: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    //print("did finish picking")
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      selectedImage = image
      profilePic.image = image
    }
    else{
      //error
    }
    dismiss(animated: true, completion: nil)
  }
}
