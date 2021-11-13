//
//  NewsViewModelTesting.swift
//  Advanced Networking LayerTests
//
//  Created by Ali Fayed on 13/11/2021.
//

import XCTest
@testable import Advanced_Networking_Layer
class NewsViewModelTesting: XCTestCase {
    // vmUT = ViewModel system under test
    var vmUT: NewsViewModel!
    var expectedPostsResponse: [Post]?
    var viewModel = NewsViewModel()

    override func setUp() {
        super.setUp()
        vmUT = NewsViewModel()
    }
    override func tearDown() {
        vmUT = nil
        super.tearDown()
    }
    func testFetchFromViewModel() {
        let exception = self.expectation(description: "Passing Data Failed")
        Task.init {
            let results = await vmUT.fetchNews()
            switch results {
            case .success(let model):
                expectedPostsResponse = model
                exception.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(expectedPostsResponse)
    }
}
