//
//  RegisterViewControllerTest.swift
//  Pick-Up GamesTests
//
//  Created by user146820 on 11/9/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import XCTest
@testable import Pick_Up_Games
import Firebase

class RegisterViewControllerTest: XCTestCase {

    var sample: sampleUser!
    
    
    override func setUp() {
        sample = sampleUser()
    }
    
    override func tearDown() {
        sample = nil
    }
    func testEmail(){
        let viewcontroller = RegisterViewController()
        XCTAssertNil(viewcontroller.EmailTF, "EMAIL IS  NOT NIL")
    }
    func testUsername(){
        let viewcontroller = RegisterViewController()
        XCTAssertNil(viewcontroller.UsernameTF, "UsernameTF IS  NOT NIL")
    }
    func testRegister(){
        Auth.auth().createUser(withEmail: sample.userEmail, password: sample.userPassword) { (user, error) in
            XCTAssertNotNil(user)
        }
    }
}
class sampleUser {
    var userEmail = "testing@ucsc.edu"
    var userPassword = "password"
    var userName = "testUser"
}
