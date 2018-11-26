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

  /*  func testRegister_login() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["An event!"]/*[[".cells.staticTexts[\"An event!\"]",".staticTexts[\"An event!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let feedNavigationBar = app.navigationBars["feed"]
        feedNavigationBar.buttons["Item"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        app.tables["Empty list"].swipeLeft()
        element2.children(matching: .navigationBar)["Profile"].buttons["feed"].tap()
        feedNavigationBar.buttons["Add"].tap()
        
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField.tap()
        textField.tap()
        textField2.tap()
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.tap()
        app.datePickers.pickerWheels["Today"].swipeUp()
        
        
    }
    func test_FeedButton(){
        
        let app = XCUIApplication()
        let feedNavigationBar = app.navigationBars["feed"]
        feedNavigationBar.buttons["Item"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        app.tables["Empty list"].swipeLeft()
        element.children(matching: .navigationBar)["Profile"].buttons["feed"].tap()
        feedNavigationBar.buttons["Add"].tap()
        app.navigationBars["createEvent"].buttons["feed"].tap()
        
    }
    func test_demoTest(){
        
        let app = XCUIApplication()
        app.navigationBars["feed"].buttons["Item"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .navigationBar)["Profile"].buttons["feed"].tap()
        
    }*/
}
