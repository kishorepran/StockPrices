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

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}

// MARK: - All other utilities
extension BaseUITestCase {
    func assertElementPosition(_ element: XCUIElement, x: CGFloat, width: CGFloat ) {
        XCTAssertEqual(x, element.frame.origin.x, "element x-position \(element.frame.origin.x) does not match \(x)" )
        XCTAssertEqual(width, element.frame.size.width, "element width \(element.frame.size.width) does not match \(width)" )
    }
    /**
     Check that an image exists with image.value == expected
     - parameter expected:  image.value
     */
    func assertImageValue(_ expected: String) {
        if let value = application.images["picture"].value as? String {
            XCTAssertEqual(expected, value, "Picture: expected '\(expected)' found '\(value)'")
        } else {
            XCTFail("Picture has no value")
        }
    }
    
    func assertKeyboardIsVisible() {
        XCTAssertEqual(application.keyboards.count, 1)
    }
    func assertKeyboardIsNotVisible() {
        XCTAssertEqual(application.keyboards.count, 0)
    }
    
    func adjustSliderto(_ amount: CGFloat) {
        application.sliders.element.adjust(toNormalizedSliderPosition: amount)
    }
    
    // MARK: - Helper
    func waitForElementToAppear(_ element: AnyObject, timeout: TimeInterval = 20, message: String? = nil, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if error != nil {
                let msg = message ?? "Failed to find \(element) after \(timeout) seconds: \(String(describing: error))"
                XCTFail(msg)
            }
        }
        
        XCTAssert(element.exists)
    }
    func waitForElementToDisappear(_ element: AnyObject, timeout: TimeInterval = 5, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == false")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if error != nil {
                let message = "Failed to find \(element) after \(timeout) seconds: \(String(describing: error))"
                XCTFail(message)
            }
        }
        
        XCTAssertFalse(element.exists)
    }
    func waitForElement(_ element: AnyObject, toFulfillPredicate predicate: NSPredicate, timeout: TimeInterval = 5, file: String = #file, line: UInt = #line) {
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if error != nil {
                let message = "Failed to find \(String(describing: element.debugDescription)) after \(timeout) seconds: \(String(describing: error))"
                XCTFail(message)
            }
        }
    }
    func waitForElement(_ element: XCUIElement, toBeEnabled enabled: Bool, timeout: TimeInterval = 5, file: String = #file, line: UInt = #line) {
        waitForElement(element, toFulfillPredicate: NSPredicate(format: "enabled = %@", enabled as CVarArg), timeout: timeout, file: file, line: line)
    }
}
// MARK: - All Alert utilities
extension BaseUITestCase {
    func pressAlertButton(_ text: String) {
        let elementsQuery = application.alerts.firstMatch
        elementsQuery.buttons[text].tap()
    }
    func pressActionSheetButton(_ text: String) {
        let elementsQuery = application.sheets.firstMatch
        elementsQuery.buttons[text].tap()
    }
    func pressSystemAlertButton(_ text: String) {
        let systemAlert = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts.firstMatch
        if systemAlert.exists {
            systemAlert.buttons["OK"].tap()
        }
    }
    func selectPhotoFromGallery(photoIndex: Int, section: Int) {
        sleep(2)
        let moments = application.tables.cells.element(boundBy: section)
        moments.tap()
        sleep(1)
        let selectedPhoto = application.collectionViews.element(boundBy: 0).cells.element(boundBy: photoIndex)
        selectedPhoto.tap()
    }
    func selectValueFromPicker(select value: String) {
        application.pickers.pickerWheels.element.adjust(toPickerWheelValue: value)
        application.buttons["Done"].tap()
    }
    func validateThenLeaveAlert(withLabel label: String) {
        let alert = application.alerts.element(boundBy: 0)
        XCTAssert(alert.exists == true)
        XCTAssert(alert.isHittable == true)
        XCTAssertEqual(label, alert.buttons.element(boundBy: 0).label)
        let button = alert.buttons[label]
        button.tap()
    }
}

// MARK: - All Key board utilities
extension BaseUITestCase {
    func type(_ item: String) {
        for char in item {
            let element = String(char)
            let key = application.keys[element]
            key.tap()
        }
    }
    func typeAllCaps(_ item: String) {
        for char in item {
            let element = String(char)
            application.buttons["shift"].tap()
            let key = application.keys[element.uppercased()]
            key.tap()
        }
    }
    func pressDelete() {
        let deleteKey = application.keys["delete"]
        deleteKey.tap()
    }
    func pressReturn() {
        let deleteKey = application.buttons["Return"]
        deleteKey.tap()
    }
    func dismissKeyboard() {
        if application.keys.element(boundBy: 0).exists {
            application.typeText("\n")
        }
    }
    func pressToolbarDone() {
        let toolbar = application.toolbars["Toolbar"]
        toolbar.buttons["Done"].tap()
    }
    func pressToolbarCancel() {
        let toolbar = application.toolbars["Toolbar"]
        toolbar.buttons["Cancel"].tap()
    }
}
