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

class ProfileEventsSubPage: UIViewController{

    @IBOutlet weak var myEventsTable: UITableView!
    
    var eventArray = [PUG]()
    
    var myID = String()
    
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
        let REF_FEED = Database.database().reference().child("Event")
        REF_FEED.observeSingleEvent(of: .value) { (feedEventSnapshot) in
            guard let feedEventSnapshot = feedEventSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for pug in feedEventSnapshot {
                if (pug.childSnapshot(forPath: "EventCreator_UserID").value as! String == self.myID) {/*Auth.auth().currentUser?.uid) {*/
                    let address = pug.childSnapshot(forPath: "EventLocation").value as! String
                    let sport = pug.childSnapshot(forPath: "EventType").value as! String
                    let players = pug.childSnapshot(forPath: "EventParticipant_Limit").value as! String
                    let name = pug.childSnapshot(forPath: "EventCreator_UserName").value as! String
                    let pug = PUG(address: address, sport: sport, players: players, name: name)
                    funcEventArray.append(pug)
                }
            }
            handler(funcEventArray)
        }
    }
    
    func numberOfSections(in myEventsTable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        
        let image = UIImage(named: "test-login")
        let event = eventArray[indexPath.row]
        
        cell.fillCell(profPic: image!, address: event.address, sport: event.sport, playerCount: event.players, name: event.name)
        return cell
        
    }
    
}
