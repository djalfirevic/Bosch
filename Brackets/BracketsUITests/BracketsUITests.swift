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
	func test_InputTextFieldExists_Success() {
		let inputTextField = application.textFields[Identifiers.inputTextField.rawValue]
		
		XCTAssertTrue(inputTextField.exists, "The input text field doesn't exist")
	}

}
