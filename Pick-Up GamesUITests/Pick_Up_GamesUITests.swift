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
            loginToApp(app: app)
        }
        
        
    }
    func testFEED(){
        
        let app = XCUIApplication()
        checkIfLoggedIn(app: app)
        
        sleep(10)
        let feedNavigationBar = app.navigationBars["feed"]
        XCTAssertTrue(feedNavigationBar.buttons["Profile"].exists)
        feedNavigationBar.buttons["Profile"].tap()
        app.navigationBars["Profile"].buttons["feed"].tap()
        feedNavigationBar.buttons["Add"].tap()
        app.navigationBars["createEvent"].buttons["feed"].tap()
                
        }
    
    func testProfile(){
        
    }
    func checkIfLoggedIn(app:XCUIElement){
        let getStartedButton = app.buttons["GET STARTED"]
        if(getStartedButton.exists)
        {
            loginToApp(app: app)
        }
    }
    func loginToApp(app:XCUIElement){
        let gotologinviewElementsQuery = app.otherElements.containing(.image, identifier:"gotoLoginView")
        let textField = gotologinviewElementsQuery.children(matching: .textField).element
        let app = XCUIApplication()
        textField.tap()
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let sKey = app.keys["s"]
        let mKey = app.keys["m"]
        let wKey = app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let eKey = app.keys["e"]
        let tKey = app.keys["t"]
        let cKey = app.keys["c"]
        let dKey = app.keys["d"]
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let atKey = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let periodKey2 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()
        
        moreKey.tap()
        atKey.tap()
        moreKey2.tap()
        
        tKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()
        
        moreKey.tap()
        periodKey2.tap()
        moreKey2.tap()
        
        cKey.tap()
        oKey.tap()
        mKey.tap()
        
        
        
        
        let secureTextField = gotologinviewElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        
        pKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sKey.tap()
        sKey.tap()
        wKey.tap()
        oKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        dKey.tap()
        
        app.buttons["GET STARTED"].tap()
    }
}
