//
//  ViewController.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController {
    
    
    @IBOutlet var UsernameTF: UITextField!
    
    @IBOutlet var LoginPasswordTF: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
                // The above needs to be implmented once we have feed page segue to feed page should be gotoFeed
            }
            
        }
    }
}

