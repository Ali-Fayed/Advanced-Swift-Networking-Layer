//
//  NewsUseCaseTesting.swift
//  Advanced Networking LayerTests
//
//  Created by Ali Fayed on 12/11/2021.
//

import XCTest
@testable import Advanced_Networking_Layer
class NewsUseCaseTesting: XCTestCase {
    // ucUT = Usecase system under test
    var ucUT: NewsUseCases!
    var expectedResultsResponse: NewsResults?
    var viewModel = NewsViewModel()

    override func setUp() {
        super.setUp()
        ucUT = NewsUseCases.shared
    }
    override func tearDown() {
        ucUT = nil
        super.tearDown()
    }
    func testFetchNewsList() {
        let fakeJSONObject = JSONMocking.shared.fakeNewsJSON
        let exception = self.expectation(description: "Fetch News Failed")
        StubRequests.shared.stubJSONrespone(jsonObject: fakeJSONObject, header: nil, statusCode: 200, absoluteStringWord: "hn.algolia.com")
        Task.init {
            let result = await ucUT.fetchNewsToViewModel(page: 0, perPage: 30, query: "")
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
}
