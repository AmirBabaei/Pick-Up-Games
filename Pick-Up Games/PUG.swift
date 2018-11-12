//
//  Message.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/1/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation

class PUG {
    private var _address: String
    private var _sport: String
    private var _players: String
    private var _name: String
    
    var address: String {
        return _address
    }
    
    var sport: String {
        return _sport
    }
    
    var players: String {
        return _players
    }
    
    var name: String {
        return _name
    }
    
    init(address: String, sport: String, players: String, name: String) {
        self._address = address
        self._sport = sport
        self._players = players
        self._name = name
    }
}
