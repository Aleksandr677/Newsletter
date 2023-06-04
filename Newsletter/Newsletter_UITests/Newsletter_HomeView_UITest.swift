//
//  Newsletter_HomeView_UITest.swift
//  Newsletter_UITests
//
//  Created by Христиченко Александр on 2023-06-04.
//

import XCTest

final class Newsletter_HomeView_UITest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_UITestingNewsletter_mainTabView_canClickOnAllTabs() {
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Favorite"].tap()
        tabBar.buttons["Home"].tap()
        
        XCTAssertTrue(tabBar.buttons["Home"].exists)
        XCTAssertTrue(tabBar.buttons["Favorite"].exists)
    }
    
    func test_UITestingNewsletter_homeScrollView_canScroll() {
        for _ in 0...3 {
            app.scrollViews.element.swipeUp()
            
        }
        
        for _ in 0...3 {
            app.scrollViews.element.swipeDown()
            
        }
        XCTAssertTrue(app.scrollViews.element.exists)
    }
}
