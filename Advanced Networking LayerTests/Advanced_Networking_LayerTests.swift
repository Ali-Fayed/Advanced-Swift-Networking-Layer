//
//  Advanced_Networking_LayerTests.swift
//  Advanced Networking LayerTests
//
//  Created by Ali Fayed on 12/11/2021.
//

import XCTest
@testable import Advanced_Networking_Layer

class Advanced_Networking_LayerTests: XCTestCase {
    var sut: ViewModel!
    var expectedResponse: [Post]?

    override func setUp() {
        super.setUp()
        sut = ViewModel()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewModel () {
        /// mocking json object
        let jsonObject = JSONMocking.shared.fakeJSON
        /// expected rsponse that will we get from the server
        let exception = self.expectation(description: "Fetch News Failed")
        /// OHTTPstubs pod give us a method to track a request or more to test it without an interaction to the server
        StubRequests.shared.stubJSONrespone(jsonObject: jsonObject, header: nil, statusCode: 200, absoluteStringWord: "github")
        Task.init {
            let result = await ViewModel().fetchNews()
            switch result {
            case .success(let model):
                expectedResponse = model
                exception.fulfill()
                XCTAssertFalse(model.isEmpty)
            case .failure(let error):
                /// make sure expected error output will not nill if there is an error
                XCTAssertNotNil(error)
            }
        }
        // timeout for 3 sec
        waitForExpectations(timeout: 3, handler: nil)
        // make sure the expectedResponse not nil
        XCTAssertNotNil(expectedResponse)
    }
}
