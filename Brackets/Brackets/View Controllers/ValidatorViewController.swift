//
//  ValidatorViewController.swift
//  Brackets
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController {

	// MARK: - Properties
	@IBOutlet private weak var inputTextField: UITextField! {
		didSet {
			inputTextField.accessibilityIdentifier = Identifiers.inputTextField.rawValue
		}
	}
	@IBOutlet private weak var resultImageView: UIImageView!
	@IBOutlet private weak var measurementLabel: UILabel!
	private let validator = Validator()
	private let successImage = #imageLiteral(resourceName: "success")
	private let failureImage = #imageLiteral(resourceName: "failure")
	
	// MARK: - View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		inputTextField.becomeFirstResponder()
	}

	// MARK: - UI Responder
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		reset()
	}
	
	// MARK: - Actions
	@IBAction private func onValidate() {
		guard validate(), let sequence = inputTextField.text else {
			showAlert(title: Messages.error.rawValue, message: Messages.pleaseEnterSequence.rawValue)
			return
		}
		
		reset()
		presentResultForSequence(sequence)
	}
	
	@IBAction private func onMeasure() {
		guard validate(), let sequence = inputTextField.text else {
			showAlert(title: Messages.error.rawValue, message: Messages.pleaseEnterSequence.rawValue)
			return
		}
		
		let measurement = Benchmark.measureBlockByCFTimeInterval {
			validator.validate(sequence)
		}
		
		Logger.log(message: "Measurement: \(measurement.formattedTime)", type: .info)
		measurementLabel.text = measurement.formattedTime
	}
	
	// MARK: - Private API
	private func presentResultForSequence(_ sequence: String) {
		let validated = validator.validate(sequence)
		
		resultImageView.image = validated ? successImage : failureImage
	}
	
	private func reset() {
		resultImageView.image = nil
		measurementLabel.text = ""
	}
	
	private func validate() -> Bool {
		guard let sequence = inputTextField.text, sequence.count > 0 else { return false }
		
		return true
	}

}

extension ValidatorViewController: UITextFieldDelegate {
	
	// MARK: - UITextFieldDelegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		reset()
		
		return true
	}
	
}

