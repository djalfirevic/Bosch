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
	@IBOutlet private weak var inputTextView: UITextView! {
		didSet {
			inputTextView.accessibilityIdentifier = Identifiers.inputTextView.rawValue
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
		
		inputTextView.becomeFirstResponder()
	}

	// MARK: - UI Responder
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		reset()
	}
	
	// MARK: - Actions
	@IBAction private func onValidate() {
		guard validate(), let sequence = inputTextView.text else {
			showAlert(title: Messages.error.rawValue, message: Messages.pleaseEnterSequence.rawValue)
			return
		}
		
		reset()
		presentResultForSequence(sequence)
	}
	
	@IBAction private func onMeasure() {
		guard validate(), let sequence = inputTextView.text else {
			showAlert(title: Messages.error.rawValue, message: Messages.pleaseEnterSequence.rawValue)
			return
		}
		
		let measurement = Benchmark.measureBlockByCFTimeInterval {
			validator.validate(sequence) { success in }
		}
		
		Logger.log(message: "Measurement: \(measurement.formattedTime)", type: .info)
		measurementLabel.text = measurement.formattedTime
	}
	
	// MARK: - Private API
	private func presentResultForSequence(_ sequence: String) {
		validator.validate(sequence) { [weak self] success in
			self?.resultImageView.image = success ? self?.successImage : self?.failureImage
		}
	}
	
	private func reset() {
		resultImageView.image = nil
		measurementLabel.text = ""
	}
	
	private func validate() -> Bool {
		guard let sequence = inputTextView.text, sequence.count > 0 else { return false }
		
		return true
	}

}
