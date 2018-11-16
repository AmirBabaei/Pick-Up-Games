//
//  CreateEventTest.swift
//  Pick-Up GamesTests
//
//  Created by user146820 on 11/15/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//
import UIKit
import XCTest
@testable import Pick_Up_Games
import Firebase

class CreateEventTest: XCTestCase {

    func test_viewDidLoad()
    {
        let sut = CreateEvent()
        
        _ = sut.view
        XCTAssertNotNil(sut.view)
    }
    
    func testCreateEvent()
    {
        let viewController = CreateEvent()
        viewController.CreateEventButton(CreateEventTest.self)
        XCTAssertNotNil(viewController.eventID)
    }
}
