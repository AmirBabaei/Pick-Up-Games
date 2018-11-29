//
//  Pick_Up_GamesUITests.swift
//  Pick-Up GamesUITests
//
//  Created by Amir Babaei on 10/12/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import XCTest

class Pick_Up_GamesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLOGIN_REGISTER() {
        
        
        let app = XCUIApplication()
        sleep(10)
        let getStartedButton = app.buttons["GET STARTED"]
        if(getStartedButton.exists)
        {
            XCTAssertTrue(getStartedButton.exists)
            getStartedButton.tap()
            
            let registerButton = app.buttons["REGISTER"]
            XCTAssertTrue(registerButton.exists)
            registerButton.tap()
            
            let window = app.children(matching: .window).element(boundBy: 0)
            let element = window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
            XCTAssertTrue(element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.exists)
            XCTAssertTrue(element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.exists)
            XCTAssertTrue(element.children(matching: .other).element(boundBy: 2).children(matching: .secureTextField).element.exists)
            XCTAssertTrue(element.children(matching: .other).element(boundBy: 3).children(matching: .secureTextField).element.exists)
            XCTAssertTrue(app.buttons["Back icon"].exists)
            app.buttons["Back icon"].tap()
            
            let element2 = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
            XCTAssertTrue(element2.children(matching: .textField).element.exists)
            XCTAssertTrue(element2.children(matching: .secureTextField).element.exists)
        }
        
        
    }
    func testFEED(){
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        let feedNavigationBar = app.navigationBars["feed"]
        sleep(20)
        feedNavigationBar.buttons["Profile"].tap()
        app.navigationBars["Profile"].buttons["feed"].tap()
        feedNavigationBar.buttons["Add"].tap()
        app.navigationBars["createEvent"].buttons["feed"].tap()
        

        
            }

}
