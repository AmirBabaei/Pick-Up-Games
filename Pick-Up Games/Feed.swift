//
//  Feed.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class Feed: UIViewController {

  //Slider
  var slideVal = 100 as Double
  @IBAction func slider(_ sender: UISlider) {
    self.slideVal = (round(10 * Double(sender.value))/10)
    sliderValue.text = "within " + String(self.slideVal) + " mils"
    getAllEvents { (returnedEventsArray) in self.eventArray = returnedEventsArray.reversed()
      self.feedTable.reloadData()
    }
  }
  //  @IBOutlet weak var feedTable: UITableView!
    
    @IBAction func Profile(_ sender: Any) {
        let UID = (Auth.auth().currentUser?.uid)!
        print("Feed UID: " + UID)
        
        let sharedID = SharedUID()
        sharedID.sharedInstance.UID = UID
        
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ProfilePage = vc.instantiateViewController(withIdentifier: "Profile") as! Profile
        
        navigationController?.pushViewController(ProfilePage, animated: true)
    }
  
  @IBOutlet weak var sliderValue: UILabel!
  
  @IBOutlet weak var feedTable: UITableView!

    var eventArray = [PUG]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.delegate = self
        feedTable.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllEvents { (returnedEventsArray) in self.eventArray = returnedEventsArray.reversed()
            self.feedTable.reloadData()
            
        }
    }
}
extension Feed: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
  
  
  
    func getAllEvents(handler: @escaping (_ events: [PUG]) -> ()) {
        var funcEventArray = [PUG]()
        let REF_FEED = Database.database().reference().child("Event")
        REF_FEED.observeSingleEvent(of: .value) { (feedEventSnapshot) in
          guard let feedEventSnapshot = feedEventSnapshot.children.allObjects as? [DataSnapshot] else { return }
          
            for pug in feedEventSnapshot {
              
                let address = pug.childSnapshot(forPath: "EventLocation").value as! String
                let distance = pug.childSnapshot(forPath: "distance").value as! CLLocationDistance
                let sport = pug.childSnapshot(forPath: "EventType").value as! String
                let players = pug.childSnapshot(forPath: "EventParticipant_Limit").value as! String
                let timeDate = pug.childSnapshot(forPath: "timeDate").value as! String
                let name = pug.childSnapshot(forPath: "EventCreator_UserName").value as! String
                let eventID = pug.key
                let pug = PUG(address: address, sport: sport, players: players, name: name, timeDate: timeDate, distance: distance, eventID: eventID)
             
              if((round(10*(pug.distance * 0.000621371192))/10) <= self.slideVal){
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
        
        let image = UIImage(named: "test-login")
        let event = eventArray[indexPath.row]
      
      cell.fillCell(profPic: image!, address: event.address, sport: event.sport, playerCount: event.players, timeDate: event.timeDate, name: event.name, distance: event.distance)
        return cell
        
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "EventView") as? EventView
    let event = eventArray[indexPath.row]
    vc?.imgs = UIImage(named: "test-login")!
    vc?.userIDs = event.name
    vc?.sports = event.sport
    vc?.addresss = event.address
    vc?.timeDates = event.timeDate
    vc?.eventID = event.eventID
    
    
  
    self.navigationController?.pushViewController(vc!, animated: true)
  }
  

  
}

