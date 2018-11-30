//
//  Message.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/1/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation
import CoreLocation
class PUG {
    private var _address: String
    private var _sport: String
    private var _players: String
    private var _name: String
    private var _timeDate: String
    private var _distance: CLLocationDistance
    private var _eventID: String
    
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
    var timeDate: String {
        return _timeDate
    }
    var distance: CLLocationDistance {
      return _distance
    }
    
    var eventID: String {
        return _eventID
    }
    
    init(address: String, sport: String, players: String, name: String, timeDate: String, distance: CLLocationDistance, eventID: String) {
        self._address = address
        self._sport = sport
        self._players = players
        self._name = name
        self._timeDate = timeDate
        self._distance = distance
        self._eventID = eventID
    }
}
