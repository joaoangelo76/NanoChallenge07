//
//  ErrorHandlerTests.swift
//  Nano07ChallengeTests
//
//  Created by João Victor Bernardes Gracês on 26/06/24.
//

import XCTest
@testable import Nano07Challenge

final class ErrorHandlerTests: XCTestCase {
    
    var apiTestURl: String = ""

    override func setUpWithError() throws {
        apiTestURl = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json"
    }

    override func tearDownWithError() throws {
       apiTestURl = ""
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func mockResponse(statusCode: Int, data: Data = Data(), mockUrl: String) -> (data: Data, response: URLResponse) {
        let url = URL(string: mockUrl)!
        let httpResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return (data, httpResponse)
    }
    
    func test_mapResponseSuccess() {
        let respoonse = mockResponse(statusCode: 200, mockUrl: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json")
        do {
            let data = try mapResponse(response: respoonse)
            XCTAssertEqual(respoonse.data, data)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
    
    func test_mapResponseBadRequestError() {
        let response = mockResponse(statusCode: 400, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.badRequest)
        }
    }
    
    
    func test_mapResponseUnauthorized() {
        let response = mockResponse(statusCode: 401, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.unauthorized)
        }
    }
    
    func test_mapResponsePaymentRequired() {
        let response = mockResponse(statusCode: 402, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.paymentRequired)
        }
    }
    
    func test_mapResponseForbidden() {
        let response = mockResponse(statusCode: 403, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.forbidden)
        }
    }
    
    func test_mapResponseNotFound() {
        let response = mockResponse(statusCode: 404, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.notFound)
        }
    }
    
    func test_mapResponseEequestEntityTooLarge() {
        let response = mockResponse(statusCode: 413, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.requestEntityTooLarge)
        }
    }
    
    func test_mapResponseUnprocessableEntity() {
        let response = mockResponse(statusCode: 422, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.unprocessableEntity)
        }
    }
    
    func test_mapUnknownError() {
        let response = mockResponse(statusCode: 500, mockUrl: apiTestURl)
        XCTAssertThrowsError(try mapResponse(response: response)) { error in
            if case NetworkError.http(let httpResponse , _) = error {
                XCTAssertEqual(httpResponse.statusCode, 500)
            } else {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }

}
