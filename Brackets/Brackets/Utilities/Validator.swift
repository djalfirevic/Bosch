//
//  Validator.swift
//  Brackets
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

import UIKit

final class Validator {

	// MARK: - Public API
	@discardableResult func validate(_ sequence: String) -> Bool {
		return isSequenceBalanced(Array(sequence))
	}
	
	// MARK: - Private API
	private func isSequenceBalanced(_ sequence: [Character]) -> Bool {
		var stack = [Character]()
		
		for bracket in sequence {
			switch bracket {
			case "{", "[", "(":
				stack.append(bracket)
			case "}", "]", ")":
				if stack.isEmpty
					|| (bracket == "}" && stack.last != "{")
					|| (bracket == "]" && stack.last != "[")
					|| (bracket == ")" && stack.last != "(") {
					return false
				}
				stack.removeLast()
			case "|":
				if let index = stack.firstIndex(of: "|") {
					stack.remove(at: index)
				} else {
					stack.append(bracket)
				}
			default:
				return false
			}
		}
		
		return stack.isEmpty
	}
	
}
