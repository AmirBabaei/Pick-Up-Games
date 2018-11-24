//
//  ProfileObject.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/9/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation

class ProfileObject {
    private var _username: String
    private var _fullName: String
    private var _email: String
    private var _age: String
    
    var username: String {
        return _username
    }
    
    var fullName: String {
        return _fullName
    }
    
    var email: String {
        return _email
    }
    
    var age: String {
        return _age
    }
    
    init(username: String, fullName: String, email: String, age: String) {
        self._username = username
        self._fullName = fullName
        self._email = email
        self._age = age
    }
}
