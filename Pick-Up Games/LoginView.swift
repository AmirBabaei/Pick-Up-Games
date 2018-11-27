//
//  ViewController.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
//import FacebookCore
//import FacebookLogin

class LoginView: UIViewController, UITextFieldDelegate{
    
  //Facebook Login
 // @IBAction func fbLogin(_ sender: Any) {
    
 // }

  
  
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // If the user was logged in and did not log out, bring them to the feed screen immediately upon reopening
        
        // Since we don't have a logout button, you cannot get to the login page because of the redirect.
        // To solve this, change the "forKey" string to be something other than "isLoggedIn".
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil) {
            self.performSegue(withIdentifier: "gotoFeed", sender: self)
        }
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
                
                // Save the user's loggeed in state
                UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                print("UserID " + Auth.auth().currentUser!.uid + " has logged in")  // Print statement for testing
                
                self.performSegue(withIdentifier: "gotoFeed", sender: self)
            }
            
        }
    }
  
  //Facebook login
  
}

