//
//  SharedUID.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/23/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import Foundation

class SharedUID {
    var sharedInstance: SharedUID {
        struct Static {
            static let instance = SharedUID()
        }
        return Static.instance
    }
    var UID: String = ""
}
