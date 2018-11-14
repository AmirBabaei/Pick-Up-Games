//
//  CreateEvent.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/29/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase

class CreateEvent: UIViewController {
  
  //for address text field
  var addressString = String()
  @IBOutlet weak var addressTexField: UITextField!
  
  
  var ref: DatabaseReference!
    override func viewDidLoad() {
      super.viewDidLoad()
      
      addressTexField.addTarget(self, action: #selector(myTargetFunction), for: UIControl.Event.touchDown)

      //address text
      addressTexField.text = addressString
      
      //date picker
      datePicker = UIDatePicker()
      datePicker?.datePickerMode = .dateAndTime
      
      dateText.inputView = datePicker
      datePicker?.addTarget(self, action: #selector(CreateEvent.dateChanged(datePicker:)), for: .valueChanged)
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateEvent.viewTapped(gestureRecognizer:)))
      
      view.addGestureRecognizer(tapGesture)
      
      
        // Do any additional setup after loading the view.
    }
  
  @objc func myTargetFunction(textField: UITextField) {
    
    let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = vc.instantiateViewController(withIdentifier: "mapScreen")
    navigationController?.pushViewController(vc2, animated: false)
    dismiss(animated: true, completion: nil)
  }
  
    //dimiss date picker
  @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
    view.endEditing(true)
  }
  
  
  
  @objc func dateChanged(datePicker: UIDatePicker){
    
    //date formatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyy 'at' HH : mm"
    dateText.text = dateFormatter.string(from: datePicker.date)
    
    //Time formatter

  }
    
  @IBOutlet var EventType: UITextField!
  @IBOutlet weak var dateText: UITextField!

  
  //date picker
  private var datePicker: UIDatePicker?
  
  
  
  
    @IBAction func CreateEventButton(_ sender: Any)
    {
        print(EventType.text!)//prints to debug console used for testing
        ref = Database.database().reference()
        let eventID = ref.child("Event").childByAutoId()
        eventID.setValue(["EventType": self.EventType.text!])
        //all values as strings for now
        eventID.updateChildValues(["EventLocation": "INSERT LOCATION VALUE HERE"])
        eventID.updateChildValues(["EventDate_Time": "INSERT Data and time"])
        eventID.updateChildValues(["EventParticipant_Limit": "INSERT Max # participants here"])
        eventID.updateChildValues(["EventAge_Min": "INSERT Min age here"])
        eventID.updateChildValues(["EventAge_Max": "INSERT Max age here"])
        eventID.updateChildValues(["EventPrivate?": "Yes or No"])
        eventID.updateChildValues(["EventDescription": "Description of event"])
        let user = Auth.auth().currentUser
        if user != nil
        {
            // User is signed in.
            ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let username = value?["username"] as? String ?? ""
                	eventID.updateChildValues(["EventCreator_UserName": username])
                	eventID.updateChildValues(["EventCreator_UserID": (user?.uid)!])
	           })
        }
        else
        {
            // No user is signed in. default values are used for these places
            //This should only happen in the case of testing where you go around login
            eventID.updateChildValues(["EventCreator_UserName": "DefaultUsername"])
            eventID.updateChildValues(["EventCreator_UserID": "DefaultUserID"])
            
        }
        //from here the createEventButton needs to return to the feed page also any checks on values should be done before this button can be pressed.

    }


}
