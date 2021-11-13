//
//  Advanced_Networking_LayerTests.swift
//  Advanced Networking LayerTests
//
//  Created by Ali Fayed on 12/11/2021.
//

import XCTest
@testable import Advanced_Networking_Layer

class Advanced_Networking_LayerTests: XCTestCase {
    // ucUT = Usecase system under test
    // vmUT = ViewModel system under test
    var ucUT: UseCases!
    var vmUT: ViewModel!
    var expectedResultsResponse: Results?
    var expectedPostsResponse: [Post]?
    var viewModel = ViewModel()

    override func setUp() {
        super.setUp()
        ucUT = UseCases.shared
        vmUT = ViewModel()
    }
    override func tearDown() {
        ucUT = nil
        vmUT = nil
        super.tearDown()
    }
    func testUseCase() {
        let jsonObject = JSONMocking.shared.fakeJSON
        let exception = self.expectation(description: "Fetch News Failed")
        StubRequests.shared.stubJSONrespone(jsonObject: jsonObject, header: nil, statusCode: 200, absoluteStringWord: "hn.algolia.com")
        Task.init {
            let result = await ucUT.fetchNewsToViewModel()
            switch result {
            case .success(let model):
                expectedResultsResponse = model
                exception.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(expectedResultsResponse)
    }
    func testViewModel() {
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
