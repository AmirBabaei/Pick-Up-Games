//
//  ProfileFriendsSubPage.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileFriendsSubPage: UIViewController{

    @IBOutlet weak var myFriendsTable: UITableView!
    
    var friendsArray = [FriendObject]()
    
    var cellID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFriendsTable.delegate = self
        myFriendsTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllFriends { (returnedFriendsArray) in self.friendsArray = returnedFriendsArray.reversed()
            self.myFriendsTable.reloadData()
            
        }
    }
}
extension ProfileFriendsSubPage: UITableViewDelegate, UITableViewDataSource {
    
    func getAllFriends(handler: @escaping (_ friends: [FriendObject]) -> ()) {
        let sharedID = SharedUID()
        let myID = sharedID.sharedInstance.UID
        
        let REF_PROF = Database.database().reference().child("users").child(myID)
        let REF_USERS = Database.database().reference().child("users")
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnapshot {
                REF_PROF.child("Friends/\(user.key)").observeSingleEvent(of: .value, with: { (friendSnapshot) in
                    if (friendSnapshot.exists()) {
                        let name = user.childSnapshot(forPath: "Full Name").value as! String
                        let UID = user.key
                        let friend = FriendObject(name: name, UID: UID)
                        if (!self.friendsArray.contains(where: { $0.UID == UID })) { self.friendsArray.append(friend) }
                    }
                    self.myFriendsTable.reloadData()
                })
            }
        }
    }
    
    func numberOfSections(in myEventsTable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Friend Cell") as? FriendCell else { return UITableViewCell() }
        
        let image = UIImage(named: "test-login")
        let friend = friendsArray[indexPath.row]

        cell.fillCell(profPic: image!, name: friend.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friendsArray[indexPath.row]
        cellID = friend.UID
        
        let sharedID = SharedUID()
        sharedID.sharedInstance.UID = cellID
        
        let vc: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = vc.instantiateViewController(withIdentifier: "OtherProfiles") as! OtherProfiles
        vc2.UID = cellID
        
        navigationController?.pushViewController(vc2, animated: true)
    }
}
