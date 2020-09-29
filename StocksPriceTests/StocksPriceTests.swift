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

class StocksPriceTests: XCTestCase {
    var promise: XCTestExpectation!
    let viewModel = SPViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchQuotes() {
        let expect = XCTestExpectation.init(description: "API Call for fetching quotes")
        promise = expect
        viewModel.delegate = self
        viewModel.fetchQuotes()
        wait(for: [expect], timeout: 10)
    }
}

extension StocksPriceTests: ViewModelDelegate {
    func viewModelDidUpdate(sender: SPBaseViewModel) {
        if let model = sender as? SPViewModel, let list = model.listStock  {
            promise.fulfill()
            XCTAssert(!list.isEmpty)
        } else {
            XCTFail()
        }
    }
    
    func viewModelUpdateFailed(error: SPError) {
        XCTFail(error.localizedMessage)
    }
    
    
}
