//
//  StocksPriceUITests.swift
//  StocksPriceUITests
//
//  Created by Pran Kishore on 27.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import XCTest

class StocksPriceUITests: BaseUITestCase {

    override func setUp() {
        super.setUp()
    }

    func testApplicationCells() throws {
        let tablesQuery = application.tables
        assertAllCellsareVisible()
        //Tap the value button and check if all the elements are still visible
        let valueButton = tablesQuery.buttons["value"]
        valueButton.tap()
        assertAllCellsareVisible()
        //Tap the percent button and check if all the elements are still visible
        tablesQuery.buttons["percent"].tap()
        valueButton.tap()

        let table = application.tables.element(boundBy: 0)
        let numberOfCells = table.cells.count
        XCTAssert(numberOfCells == 12) // Assert of all the 5 elements are visible
    }
    func assertAllCellsareVisible() {
        let tablesQuery = application.tables
        //Take up first cell and assert if all the five elements are visible.
        let cell = tablesQuery.cells.element(boundBy: 1)
        let numberOfLabels = cell.staticTexts.count
        XCTAssert(numberOfLabels == 5) // Assert of all the 5 elements are visible
    }
}
