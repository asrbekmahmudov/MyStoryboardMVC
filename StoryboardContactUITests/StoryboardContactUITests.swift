//
//  StoryboardContactUITests.swift
//  StoryboardContactUITests
//
//  Created by Mahmudov Asrbek Ulug'bek o'g'li on 23/10/21.
//

import XCTest

class StoryboardContactUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    // MARK: Contact View UI Tests
    func testWithStaticText() throws {
        app.launch()
        XCTAssertTrue(app.staticTexts["Storyboard Contact"].exists)
    }
    
    func testWithNavigationTitle() {
        app.launch()
        XCTAssert(app.navigationBars["Storyboard Contact"].exists)
    }
    
    func testWithNavigationButton() {
        app.launch()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func testWithTableViewExist() {
        app.launch()
        
        let ex = expectation(description: "testWithTableViewExist")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertTrue(self.app.tables.element.exists)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testWithTableViewCellCount() throws {
        app.launch()
        
        let ex = expectation(description: "testWithTableViewCellCount")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertEqual(self.app.tables.cells.count, 13)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 20, handler: { error in
            if let error = error {
                XCTFail("error: \(error)")
            }
        })
    }
    
    // MARK: Creat View UI Test
    
    func testWithCreateViewTextFields() throws {
        app.launch()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("Jeff Bezos")
        XCTAssertEqual(nameTextField.value as! String, "Jeff Bezos")
        
        let phoneTextField = app.textFields["Phone"]
        phoneTextField.tap()
        phoneTextField.typeText("7654321")
        XCTAssertEqual(phoneTextField.value as! String, "7654321")
    }
    
    func testWithCreateViewButtons() throws {
        app.launch()
        app.buttons.element.tap()
    }
    
    // MARK: Edit View UI Tests
    func testWithEditViewNavigationTitle() throws {
        app.launch()
        XCTAssert(app.navigationBars["Edit Contact"].exists)
    }
    
    func testWithEditViewTextFields() throws {
        app.launch()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("Elon Musk")
        XCTAssertEqual(nameTextField.value as! String, "Elon Musk")
        
        let phoneTextField = app.textFields["Phone"]
        phoneTextField.tap()
        phoneTextField.typeText("1234567")
        XCTAssertEqual(phoneTextField.value as! String, "1234567")
    }
    
    func testWithEditViewButtons() throws {
        app.launch()
        app.buttons.element.tap()
    }
}
