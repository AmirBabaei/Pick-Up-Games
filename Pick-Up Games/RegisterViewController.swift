//
//  RegisterViewController.swift
//  Pick-Up Games
//
//  Created by raul pineda on 10/18/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class RegisterViewController: UIViewController {

    
    @IBOutlet var UsernameTF: UITextField!
    
    @IBOutlet var EmailTF: UITextField!
  
    @IBOutlet var PasswordTf: UITextField!

    @IBOutlet var ConPassTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

/*  @IBAction func BackB(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToLogin", sender: nil)
  }*/
  
  
  
  @IBAction func RegisterPressed(_ sender: Any) {
    Auth.auth().createUser(withEmail: EmailTF.text!, password: PasswordTf.text!) { (user, error) in
    var ref: DatabaseReference!
    if self.PasswordTf.text! != self.ConPassTF.text!
      {
        print("Passwords do not match!")
        //need to add functionality so that the user will not be registered
      }
      else{
        if error != nil{
            print(error!)
            print(">>>>>>>failed to register<<<<<<<<")
            }
        else
      {
        print("registration successful!")
        ref = Database.database().reference()
        ref.child("users").child((user?.user.uid)!).setValue(["username": self.UsernameTF.text!])
        self.performSegue(withIdentifier: "gotoLoginView", sender: self)
      }
        }
    }
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
