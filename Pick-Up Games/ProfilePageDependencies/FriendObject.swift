//
//  FriendObject.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/15/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation

class FriendObject {
    private var _name: String
    private var _UID: String
    
    var name: String {
        return _name
    }
    
    var UID: String {
        return _UID
    }
    
    init(name: String, UID: String) {
        self._name = name
        self._UID = UID
    }
}