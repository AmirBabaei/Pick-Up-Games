//
//  EventView.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 11/23/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class EventView: UIViewController {
  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var userId: UILabel!
  @IBOutlet weak var sport: UILabel!
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var timeDate: UILabel!
  @IBOutlet weak var descript: UILabel!
  
  
  var imgURL = ""
   var userIDs = ""
   var sports = ""
   var addresss = ""
   var timeDates = ""
    var descripts = ""
    var eventID = ""
    
    @IBAction func Attend(_ sender: Any) {
        let myUserID = (Auth.auth().currentUser?.uid)!
        let REF_EVENT = Database.database().reference().child("Event").child(eventID)
        
        REF_EVENT.child("Attendees/\(myUserID)").observeSingleEvent(of: .value, with: { (attendeeSnapshot) in
            if (!attendeeSnapshot.exists()) {
                REF_EVENT.child("Attendees/\(myUserID)").setValue("")
            }
        })
        
        let REF_MY_PROF = Database.database().reference().child("users").child(myUserID)
        
        REF_MY_PROF.child("Events/\(eventID)").observeSingleEvent(of: .value, with: { (eventSnapshot) in
            if (!eventSnapshot.exists()) {
                REF_MY_PROF.child("Events/\(self.eventID)").setValue("")
            }
        })
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var attendeesTable: UITableView!
    
    var attendeesArray = [FriendObject]()
    
    var cellID: String!
  
  override func viewDidLoad() {
    
    img.roundIt()
    super.viewDidLoad()
      if (imgURL != "") {
          print ("I got the url")
          let url = URL(string: imgURL)
          self.img.kf.setImage(with: url)
      } else {
          self.img.image = UIImage(named: "test-login")
      }
     userId.text = userIDs
     sport.text = sports
     address.text = addresss
     timeDate.text = timeDates

    
    attendeesTable.delegate = self
    attendeesTable.dataSource = self
    
  }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllAttendees { (returnedAttendeesArray) in self.attendeesArray = returnedAttendeesArray.reversed()
            self.attendeesTable.reloadData()
            
        }
    }
}
extension EventView: UITableViewDelegate, UITableViewDataSource {
    
    func getAllAttendees(handler: @escaping (_ attendees: [FriendObject]) -> ()) {
        let REF_EVENT = Database.database().reference().child("Event").child(eventID)
        let REF_USERS = Database.database().reference().child("users")
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnapshot {
                REF_EVENT.child("Attendees/\(user.key)").observeSingleEvent(of: .value, with: { (attendeeSnapshot) in
                    if (attendeeSnapshot.exists() && (user.hasChild("Full Name") || user.hasChild("username"))) {
                        var imageURL = ""
                        if (user.childSnapshot(forPath: "ProfilePicURL").exists()) {
                            imageURL = user.childSnapshot(forPath: "ProfilePicURL").value as! String
                        }
                        var name = ""
                        if (user.hasChild("Full Name")) {
                            name = user.childSnapshot(forPath: "Full Name").value as! String
                        } else {
                            name = user.childSnapshot(forPath: "username").value as! String
                        }
                        let UID = user.key
                        let attendee = FriendObject(profPicURL: imageURL, name: name ?? "", UID: UID)
                        if (!self.attendeesArray.contains(where: { $0.UID == UID })) { self.attendeesArray.append(attendee) }
                    }
                    self.attendeesTable.reloadData()
                })
            }
        }
    }
    
    func numberOfSections(in myEventsTable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendeesArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Friend Cell") as? FriendCell else { return UITableViewCell() }
        
        let attendee = attendeesArray[indexPath.row]
        
        cell.fillCell(profPicURL: attendee.profPicURL, name: attendee.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let attendee = attendeesArray[indexPath.row]
        cellID = attendee.UID
        
        let sharedID = SharedUID()
        sharedID.sharedInstance.UID = cellID
        
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = vc.instantiateViewController(withIdentifier: "OtherProfiles") as! OtherProfiles
        vc2.UID = cellID
        
        navigationController?.pushViewController(vc2, animated: true)
    }
}

