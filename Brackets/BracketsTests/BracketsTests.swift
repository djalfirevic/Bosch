//
//  BracketsTests.swift
//  BracketsTests
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

import XCTest
@testable import Brackets

class BracketsTests: XCTestCase {

	// MARK: - Properties
	let validator = Validator()
	
	// MARK: - Tests
	func test_CurlyBrackets_Success() {
		// Arrange
		let sequence = "{}"
		
		// Act
		let result = validator.validate(sequence)
		
		// Assert
		XCTAssertTrue(result, "Validation failed!")
	}
	
	func test_ParenthesesAndCurlyBrackets_Success() {
		// Arrange
		let sequence = "{()}"
		
		// Act
		let result = validator.validate(sequence)
		
		// Assert
		XCTAssertTrue(result, "Validation failed!")
	}
	
	func test_ParenthesesAndCurlyBrackets_Failure() {
		// Arrange
		let sequence = "{()}]"
		
		// Act
		let result = validator.validate(sequence)
		
		// Assert
		XCTAssertFalse(result, "Validation failed!")
	}
	
	func test_ParenthesesCurlyBracketsAndPipes_Success() {
		// Arrange
		let sequence = "{|()|}"
		
		// Act
		let result = validator.validate(sequence)
		
		// Assert
		XCTAssertTrue(result, "Validation failed!")
	}
	
	func test_GivenExample_Success() {
		// Arrange
		let sequence = "{|[]|()}"
		
		// Act
		let result = validator.validate(sequence)
		
		// Assert
		XCTAssertTrue(result, "Validation failed!")
	}
	
}
