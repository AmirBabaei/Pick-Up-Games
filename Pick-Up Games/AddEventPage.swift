//
//  AddEventPage.swift
//  Pick-Up Games
//
//  Created by Kyle on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

// Something I should note is that I couldn't find a layout for this on the XCD file, so I just made a general, likely temporary page layout.

//TODO:
// Add the back button
// Send info to Firebase after the "Create Event" button is pushed
// Link up with feed

import UIKit
	
class AddEventView: UIViewController {
    
   // Link to the event text field and picker view
    @IBOutlet weak var EventTxtField: UITextField!
    @IBOutlet weak var EventPickerView: UIPickerView!
    
    // Link to the Location text field
    @IBOutlet weak var LocationTxtField: UITextField!
    
    // Link to the Time text field
    @IBOutlet weak var DateAndTimeTxtField: UITextField!
    
    // Link to the Participant Limit text field
    @IBOutlet weak var ParticipantLimitTxtField: UITextField!
    
    // Link to the Age limit text field
    @IBOutlet weak var AgeMaxTxtField: UITextField!
    
    @IBOutlet weak var AgeMinTextField: UITextField!
    
    // Link to the Description text field
    @IBOutlet weak var DescriptionTxtField: UITextField!
    
    // Private/Public event switch
    @IBOutlet weak var PrivatePublicSwitch: UISwitch!
    
    private var dateTimePicker: UIDatePicker?
    
    var eventMenuOptions = ["","Football","Baseball","Basketball","Soccer","Tennis","Rugby","Hockey","Cricket"]    // We can decide on sports later, just want to have a few for now
    
    
    
    
    // Creates the event
    // This would involve sending data to Firebase, which I don't know how to do quite yet.
    
    // This should take error handling as well
    @IBAction func CreateEventButton(_ sender: UIButton) {
    
        // Tell server to put event in event feed only when event == public
        
        // Establish the var's with the information of the event
        var event: String = ""
        var location : String = ""
        var dateTime : String = ""
        var partLimit : String = ""
        var ageRange : String = ""
        var description : String = ""
        var visibility : Bool = false  // Initializing visibility to be false so that we need to do nothing if the event is public. Only display the message.
        
        // Checks for event field
        if(EventTxtField.text == "" || EventTxtField.text == nil) {
            print("Error in Event field. Text field was nil or left blank.")
            return
        } else {
            event = EventTxtField.text!
        }
        
        // Check for location field
        // Needs the check for valid location
        if(LocationTxtField.text == nil) {
            print("Error in location field. Text field is blank")
            return
        } else {
            // Despite the ! operator, the prior step should ensure that Location will resolve to a non-nil string
            location = LocationTxtField.text!
        }
        
        // Check for date and time
        if(DateAndTimeTxtField.text == nil) {
            print("Error in Date/Time text field. Text field is  blank.")
            return
        } else {
            dateTime = DateAndTimeTxtField.text!
        }
        
        // Participant Limit
        if(ParticipantLimitTxtField.text == nil) {
            print("Error in Participant limit field. Text field is blank.")
            return
        } else {
            partLimit = ParticipantLimitTxtField.text!
        }
        
        // Age Limits
        
        // If they are both empty, then set the age range to Any Age
        if(AgeMaxTxtField == nil && AgeMinTextField == nil) {
            ageRange = "Any age"
        }
        
        // The max field has no text, but the min field does
        if(AgeMaxTxtField == nil && AgeMinTextField != nil) {
            print("Error in age range field. Max range DNE while min range does.")
            return
        }
        
        // The min field has no text, but the max field does
        if(AgeMaxTxtField != nil && AgeMinTextField == nil) {
            print("Error in age range field. Min range DNE while max range does.")
            return
        }
        
        // Checking to make sure that max > min
        // This is a bit more complicated, as I'm not sure how to cast this properly to do the conditional
        
        
        
        // Private or public
        if(PrivatePublicSwitch.isOn == true) {
            print("The event is set to public.")
            visibility = true
            // Do some witchcraft and let the server know that it is okay to share this event with other people publically.
        } else {
            print("The event is set to private.")
            return
        }
        
        // Check the description
        if(DescriptionTxtField.text == nil || DescriptionTxtField.text == "") {
            print("Error in description field. Left blank.")
            return
        } else {
            description = DescriptionTxtField.text!
        }
        
        // Now that we have passed all the checks, we send all the information to the database to make a new event.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTimePicker = UIDatePicker()
        //dateTimePicker?.datePickerMode =
        dateTimePicker?.addTarget(self, action: #selector(AddEventView.dateChanged(dateTimePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddEventView.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer((tapGesture))
        
        DateAndTimeTxtField.inputView = dateTimePicker
        
        // Do any additional setup after loading the view, typically from a nib
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(dateTimePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy - HH:mm:ss"
        DateAndTimeTxtField.text = dateFormatter.string(from: dateTimePicker.date)
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    func numberOfPickerComponentsInView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numRowsInComponent comp: Int) -> Int {
        return eventMenuOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, rowTitle row: Int, forComponent comp: Int) -> String! {
        self.view.endEditing(true)
        return eventMenuOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent comp: Int) {
        self.EventTxtField.text = self.eventMenuOptions[row]
        self.EventPickerView.isHidden = true
    }
    
    func chooseingEvent(textField: UITextField) {
        if textField == self.EventTxtField {
            self.EventPickerView.isHidden = false
        }
    }
    
}
