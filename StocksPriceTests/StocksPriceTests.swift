//
//  StocksPriceTests.swift
//  StocksPriceTests
//
//  Created by Pran Kishore on 27.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import StocksPrice

class StocksPriceTests: StockPriceBaseTests {

    let viewModel = SPViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchQuotes() {
        stub(condition: matcher, response: provider)
        let expect = XCTestExpectation.init(description: "API Call for fetching quotes")
        promise = expect
        viewModel.delegate = self
        viewModel.fetchQuotes()
        wait(for: [expect], timeout: 10)
    }
    // MARK: - Test JSON parsing error
    func testFetchQuotesJSONError() {
        stub(condition: matcher, response: errorProvider)
        let expect = XCTestExpectation.init(description: "API Call for fetching quotes JSON error")
        promise = expect
        expectedError = "Internal error. Please try again later."
        errorFile = "get-quotes-error"
        viewModel.delegate = self
        viewModel.fetchQuotes()
        wait(for: [expect], timeout: 10)
    }
}

extension StocksPriceTests: ViewModelDelegate {
    func viewModelDidUpdate(sender: SPBaseViewModel) {
        if let model = sender as? SPViewModel, let list = model.listStock {
            promise.fulfill()
            XCTAssert(!list.isEmpty)
        } else {
            XCTFail("Unexpected error in services")
        }
    }

    func viewModelUpdateFailed(error: SPError) {
        if let expError = expectedError {
            XCTAssert(error.localizedMessage == expError)
            promise?.fulfill()
        } else {
            XCTFail(error.localizedMessage)
        }
    }

}
