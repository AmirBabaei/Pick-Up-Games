//
//  Feed.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 10/25/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit

class Feed: UIViewController, UITableViewDelegate, UITableViewDataSource {


  @IBOutlet var feedTable: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
    return cell
  }
  



}
