//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
// MARK: - @IBOUTLETS
    @IBOutlet weak var textView: UITextView!
    var calculator = Calculator()

// MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        setupTextView()
    }

// MARK: - @IBACTIONS
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(number: sender.titleLabel?.text ?? "")
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        calculator.addOperator(operator: ("  \(sender.titleLabel?.text ?? "")  "))
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.doCalcul()
    }

    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.ACButton()
    }

    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        calculator.deleteButton()
    }

    @IBAction func tappedDecimalButton(_ sender: UIButton) {
        calculator.addDecimal(point: sender.titleLabel?.text ?? "")
    }

// MARK: - PRIVATE FUNC
    private func setupTextView() {
        textView.text = calculator.calculString
        textView.layer.cornerRadius = 25
    }

}

// MARK: - EXTENSION
extension ViewController: CalculatorDelegate {
    // definition of protocol methods

    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }

    func setupCalcul(calculString: String) {
        textView.text = calculString
    }
}
