//
//  Nano07ChallengeUITests.swift
//  Nano07ChallengeUITests
//
//  Created by Kaua Miguel on 27/06/24.
//

import XCTest

final class Nano07ChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testSearchBar() throws {
       
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
