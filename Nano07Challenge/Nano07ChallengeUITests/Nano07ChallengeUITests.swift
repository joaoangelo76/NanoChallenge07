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
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {

    }
    
    func testMainButtonsExists() {
        
        let app = XCUIApplication()
        
        let firstCoinButton = app.buttons["Moeda de Origem"]
        XCTAssertTrue(firstCoinButton.exists)
        let secondCoinButton = app/*@START_MENU_TOKEN@*/.staticTexts["Moeda de Destino"]/*[[".buttons[\"Moeda de Destino\"].staticTexts[\"Moeda de Destino\"]",".staticTexts[\"Moeda de Destino\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(secondCoinButton.exists)
        let convertButton = app/*@START_MENU_TOKEN@*/.staticTexts["Converter"]/*[[".buttons[\"Converter\"].staticTexts[\"Converter\"]",".staticTexts[\"Converter\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(convertButton.exists)
        
    }

    func testSearchBarExist(){
        let searchBar = XCUIApplication()/*@START_MENU_TOKEN@*/.textFields["SearchBar"]/*[[".textFields[\"Start typing to search...\"]",".textFields[\"SearchBar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchBar.exists)
    }
    
    func testSearchBar() throws {
        
        let app = XCUIApplication()
        app.buttons["Moeda de Origem"].tap()
        app/*@START_MENU_TOKEN@*/.textFields["SearchBar"]/*[[".textFields[\"Start typing to search...\"]",".textFields[\"SearchBar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let bKey = app.keys["B"]
        bKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSortButtonExist(){
        let sortButton = XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Code"]/*[[".buttons[\"Code\"].staticTexts[\"Code\"]",".staticTexts[\"Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(sortButton.exists)
    }
    
    func testSortButton(){
        let codeStaticText = XCUIApplication().staticTexts["Code"]
        codeStaticText.tap()
        codeStaticText.tap()
    }
}
