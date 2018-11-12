//
//  Data Service.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/1/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    
    
}
