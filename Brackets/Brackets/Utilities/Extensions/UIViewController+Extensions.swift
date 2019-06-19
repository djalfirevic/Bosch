//
//  UIViewController+Extensions.swift
//  Brackets
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	
	func showAlert(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
		present(alertController, animated: true)
	}
	
}
