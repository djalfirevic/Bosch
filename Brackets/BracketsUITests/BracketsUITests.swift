//
//  BracketsUITests.swift
//  BracketsUITests
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

import XCTest

class BracketsUITests: XCTestCase {

	// MARK: - Properties
	var application: XCUIApplication!
	
	// MARK: - Setup
	override func setUp() {
		continueAfterFailure = false
		application = XCUIApplication()
		application.launch()
		XCUIDevice.shared.orientation = .portrait
	}
	
	// MARK: - Tests
	func test_InputTextViewExists_Success() {
		let inputTextView = application.textViews[Identifiers.inputTextView.rawValue]
		
		XCTAssertTrue(inputTextView.exists, "The input text view doesn't exist")
	}

}
