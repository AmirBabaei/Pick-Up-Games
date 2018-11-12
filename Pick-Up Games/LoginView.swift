//
//  ViewController.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var UsernameTF: UITextField!
    
    @IBOutlet var LoginPasswordTF: UITextField!
  
  
  //hide keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
    override func viewDidLoad() {
    super.viewDidLoad()
      UsernameTF.delegate = self
      LoginPasswordTF.delegate = self
  }


  @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }

    @IBAction func Login_button(_ sender: Any) {
        Auth.auth().signIn(withEmail: UsernameTF.text!, password: LoginPasswordTF.text!) { (user, error) in
            
            if error != nil{
                print(">>>>>>>>> LOGIN FAILED <<<<<<<<<")
                print(error!)
            }
            else{
                print(">>>>>>>>> login successful <<<<<<<<<<")
                self.performSegue(withIdentifier: "gotoFeed", sender: self)
            }
            
        }
    }
}

