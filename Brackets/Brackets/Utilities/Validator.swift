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
	
	func validate(_ sequence: String, completion: @escaping (Bool) -> Void) {
		DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
			let result = self.isSequenceBalanced(Array(sequence))
			
			DispatchQueue.main.async {
				completion(result)
			}
		}
	}
	
	// MARK: - Private API
	private func isSequenceBalanced(_ sequence: [Character]) -> Bool {
		var stack = [Character]()
		
		// {filip ()}
		
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
			default:
				continue
			}
		}
		
		return stack.isEmpty
	}
	
}
