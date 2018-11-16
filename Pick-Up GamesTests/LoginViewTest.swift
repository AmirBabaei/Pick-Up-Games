//
//  LoginViewTest.swift
//  Pick-Up GamesTests
//
//  Created by user146820 on 11/9/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import XCTest
@testable import Pick_Up_Games
import Firebase

class LoginViewTest: XCTestCase {

    var sample: sampleUser!
    var sample2: sampleUser2!
    override func setUp()
    {
        sample = sampleUser()
        sample2 = sampleUser2()
    }
    override func tearDown() {
        sample = nil
        sample2 = nil
    }
    func testLogin()
    {
        Auth.auth().signIn(withEmail: sample.userEmail, password: sample.userPassword) { (user, error) in
            XCTAssertNil(error, "should be nil not a real user")
        }
    }

    func testLogin2()
    {
        Auth.auth().signIn(withEmail: sample.userEmail, password: sample.userPassword) { (user, error) in
            XCTAssertNotNil(error, "should not be nil is a real user")
        }
    }
    

}
class sampleUser2 {
    var userEmail = "repineda@ucsc.edu"
    var userPassword = "password"
    var userName = "Lito"
}
