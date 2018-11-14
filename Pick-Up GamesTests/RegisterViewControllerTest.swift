//
//  RegisterViewControllerTest.swift
//  Pick-Up GamesTests
//
//  Created by user146820 on 11/9/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import XCTest
@testable import Pick_Up_Games

class RegisterViewControllerTest: XCTestCase {

    var sample: sampleUser!
    override func setUp() {
        sample = sampleUser()
    }

    override func tearDown() {
        sample = nil
    }
    func testPassword(){
        let viewcontroller = RegisterViewController()
        XCTAssertEqual(viewcontroller.PasswordTf.text, viewcontroller.ConPassTF.text
        )
    }
    func testEmail(){
        let viewcontroller = RegisterViewController()
        XCTAssertNil(viewcontroller.EmailTF, "EMAIL IS  NOT NIL")
    }
    func testUsername(){
        let viewcontroller = RegisterViewController()
        XCTAssertNil(viewcontroller.UsernameTF, "UsernameTF IS  NOT NIL")
    }
}
class sampleUser {
    var userEmail = "testing@ucsc.edu"
    var userPassword = "password"
    var userName = "testUser"
}
