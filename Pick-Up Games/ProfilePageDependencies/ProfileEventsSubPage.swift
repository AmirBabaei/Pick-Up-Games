//
//  ProfileEventsSubPage.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreLocation

class ProfileEventsSubPage: UIViewController{

    @IBOutlet weak var myEventsTable: UITableView!
    
    var eventArray = [PUG]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEventsTable.delegate = self
        myEventsTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllEvents { (returnedEventsArray) in self.eventArray = returnedEventsArray.reversed()
            self.myEventsTable.reloadData()
            
        }
    }
}
extension ProfileEventsSubPage: UITableViewDelegate, UITableViewDataSource {
    
    func getAllEvents(handler: @escaping (_ events: [PUG]) -> ()) {
        var funcEventArray = [PUG]()
        
        let sharedID = SharedUID()
        let myID = sharedID.sharedInstance.UID
        
        let REF_FEED = Database.database().reference().child("Event")
        REF_FEED.observeSingleEvent(of: .value) { (feedEventSnapshot) in
            guard let feedEventSnapshot = feedEventSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for pug in feedEventSnapshot {
                if (pug.childSnapshot(forPath: "EventCreator_UserID").value as! String == myID || pug.childSnapshot(forPath: "Attendees").hasChild(myID)) {
                    
                    var imageURL = ""
                    if (pug.childSnapshot(forPath: "EventCreator_ProfPic").exists()) {
                        imageURL = pug.childSnapshot(forPath: "EventCreator_ProfPic").value as! String
                    }
                    let address = pug.childSnapshot(forPath: "EventLocation").value as! String
                    let distance = pug.childSnapshot(forPath: "distance").value as! CLLocationDistance
                    let sport = pug.childSnapshot(forPath: "EventType").value as! String
                    let players = pug.childSnapshot(forPath: "EventParticipant_Limit").value as! String
                    let timeDate = pug.childSnapshot(forPath: "timeDate").value as! String
                    let name = pug.childSnapshot(forPath: "EventCreator_UserName").value as! String
                    let eventID = pug.key
                    
                    let pug = PUG(imageURL: imageURL, address: address, sport: sport, players: players, name: name, timeDate: timeDate, distance: distance, eventID: eventID)
                    
                    funcEventArray.append(pug)
                }
            }
            handler(funcEventArray)
        }
    }
    
    func numberOfSections(in feedTable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }

        let event = eventArray[indexPath.row]
        
        cell.fillCell(profPicURL: event.imageURL, address: event.address, sport: event.sport, playerCount: event.players, timeDate: event.timeDate, name: event.name, distance: event.distance)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventView") as? EventView
        let event = eventArray[indexPath.row]
        vc?.imgURL = event.imageURL
        vc?.userIDs = event.name
        vc?.sports = event.sport
        vc?.addresss = event.address
        vc?.timeDates = event.timeDate
        vc?.eventID = event.eventID
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
