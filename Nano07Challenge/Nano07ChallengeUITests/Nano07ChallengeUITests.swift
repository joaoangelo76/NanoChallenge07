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

    func testSearchBar() throws {
        
                let app = XCUIApplication()
        app.textFields["Start typing to search..."].tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let fKey = app/*@START_MENU_TOKEN@*/.keys["f"]/*[[".keyboards.keys[\"f\"]",".keys[\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fKey.tap()
        
        let aKey2 = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey2.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSortButton(){
        let codeStaticText = XCUIApplication().staticTexts["Code"]
        codeStaticText.tap()
        codeStaticText.tap()
    }
    
    func testSortButtonExist(){
        let sortButton = XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Code"]/*[[".buttons[\"Code\"].staticTexts[\"Code\"]",".staticTexts[\"Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(sortButton.exists)
    }
    
    func testSearchBarExist(){
        let searchBar = XCUIApplication()/*@START_MENU_TOKEN@*/.textFields["SearchBar"]/*[[".textFields[\"Start typing to search...\"]",".textFields[\"SearchBar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchBar.exists)
    }
}
