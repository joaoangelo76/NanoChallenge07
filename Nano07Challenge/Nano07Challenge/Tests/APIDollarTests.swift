//
//  APITests.swift
//  Nano07Challenge
//
//  Created by João Victor Bernardes Gracês on 28/06/24.
//

import Foundation
import XCTest
@testable import Nano07Challenge

final class APIDollarTests: XCTestCase {
    
    var apiTestURl: String = ""
    var apiMangager: APIManager!
    var mockAPIFetch: FetchMockData!

    override func setUpWithError() throws {
        apiTestURl = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json"
        apiMangager = APIManager()
        mockAPIFetch = FetchMockData()
    }

    override func tearDownWithError() throws {
       apiTestURl = ""
        apiMangager = nil
        mockAPIFetch = nil
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
    
    func mockMapResponse(statusCode: Int, data: Data = Data(), mockUrl: String) -> (data: Data, response: URLResponse) {
        let url = URL(string: mockUrl)!
        let httpResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return (data, httpResponse)
    }
    
    func test_mapResponseSuccess() {
        let response = mockMapResponse(statusCode: 200, mockUrl: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json")
        do {
            let data = try apiMangager.mapResponse(response: response)
            XCTAssertEqual(response.data, data)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
    
    func test_mapResponseBadRequestError() {
        let response = mockMapResponse(statusCode: 400, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.badRequest)
        }
    }
    
    
    func test_mapResponseUnauthorized() {
        let response = mockMapResponse(statusCode: 401, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.unauthorized)
        }
    }
    
    func test_mapResponsePaymentRequired() {
        let response = mockMapResponse(statusCode: 402, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.paymentRequired)
        }
    }
    
    func test_mapResponseForbidden() {
        let response = mockMapResponse(statusCode: 403, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.forbidden)
        }
    }
    
    func test_mapResponseNotFound() {
        let response = mockMapResponse(statusCode: 404, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.notFound)
        }
    }
    
    func test_mapResponseEequestEntityTooLarge() {
        let response = mockMapResponse(statusCode: 413, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.requestEntityTooLarge)
        }
    }
    
    func test_mapResponseUnprocessableEntity() {
        let response = mockMapResponse(statusCode: 422, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            XCTAssertEqual(error as? FetchError, FetchError.unprocessableEntity)
        }
    }
    
    func test_mapUnknownError() {
        let response = mockMapResponse(statusCode: 500, mockUrl: apiTestURl)
        XCTAssertThrowsError(try apiMangager.mapResponse(response: response)) { error in
            if case FetchError.http(let httpResponse , _) = error {
                XCTAssertEqual(httpResponse.statusCode, 500)
            } else {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    struct MockObject: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    func testFetchSuccess() async {
        let urlSessionMock = URLSessionMock()
        let mockObject = MockObject(id: 1, name: "Test")
        urlSessionMock.data = try! JSONEncoder().encode(mockObject)
        urlSessionMock.response = HTTPURLResponse(url: URL(string: apiTestURl)!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        
        let result = await mockAPIFetch.fetch(httpLink: apiTestURl, object: MockObject.self, session: urlSessionMock)
        
        switch result {
        case .success(let object):
            XCTAssertEqual(object, mockObject)
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchInvalidURL() async {
        let result = await mockAPIFetch.fetch(httpLink: "invalid-url", object: MockObject.self)
        
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .invalidURL)
        }
    }
}

