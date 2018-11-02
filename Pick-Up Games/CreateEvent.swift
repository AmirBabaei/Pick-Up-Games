//
//  CreateEvent.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/29/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase

class CreateEvent: UIViewController, UITextFieldDelegate{
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.ParticipLimitTxtField.delegate = self
    }
    
    
    @IBOutlet var EventType: UITextField!
    @IBOutlet var ParticipLimitTxtField: UITextField!
    @IBOutlet var AgeLimitMinTxtField: UITextField!
    @IBOutlet var AgeLimitMaxTxtField: UITextField!
    @IBOutlet var DescriptionTxtField: UITextField!
    
    
    // This stuff has to do with the sport picker view that I have been looking into, but doesn't work
    /*
    var eventTypes = ["Football", "Baseball"]
    var selectedEvent: String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEvent = eventTypes[row]
        EventType.text = selectedEvent!
    }
    
    func createPickerView() {
        let view = UIPickerView()
        view.delegate = self
        
        EventType.inputView = view
    }
 */
   /*
    func stringToInt(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return -1
        }
        
        return number
    }
 */
    /*
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ParticipLimitTxtField.resignFirstResponder()
        return true
    }
    */
    @IBAction func CreateEventButton(_ sender: Any)
    {
        /*
        var event: String?
        var partLimit: String?
        var maxAge: String?
        var minAge: String?
        var description: String?

        // Getting the Participant Limit
        if(ParticipLimitTxtField.text! == "")
        {
            partLimit = "No participant limit specified."
        } else {
            partLimit = ParticipLimitTxtField.text!
        }
 */
        /*
        // Comparing min and max age fields so that they are in order
        var max = stringToInt(from: AgeLimitMaxTxtField)
        var min = stringToInt(from: AgeLimitMinTxtField)
        
        // The max age is less than the min age, so lets just swap them around
        if(max < min) {
            maxAge = AgeLimitMinTxtField.text!
            minAge = AgeLimitMaxTxtField.text!
        }
 */
        
        print(EventType.text!)//prints to debug console used for testing
        ref = Database.database().reference()
        let eventID = ref.child("Event").childByAutoId()
        eventID.setValue(["EventType": self.EventType.text!])
        //all values as strings for now
        eventID.updateChildValues(["EventLocation": "INSERT LOCATION VALUE HERE"])
        eventID.updateChildValues(["EventDate_Time": "INSERT Data and time"])
        eventID.updateChildValues(["EventParticipant_Limit": "wumob"])
        eventID.updateChildValues(["EventAge_Min": "test1"])
        eventID.updateChildValues(["EventAge_Max": "test2"])
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
