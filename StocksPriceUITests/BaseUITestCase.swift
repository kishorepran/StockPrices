//
//  BaseUITestCase.swift
//  StocksPriceUITests
//
//  Created by Pran Kishore on 30.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import XCTest

class BaseUITestCase: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application = XCUIApplication()
        application.launchEnvironment = ["Mock-API": "true"]
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
