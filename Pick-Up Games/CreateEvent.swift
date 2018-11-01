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
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var EventType: UITextField!
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
