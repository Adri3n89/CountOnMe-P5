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

// MARK: - PRIVATE VARIABLE
    private var calculator = Calculator()

// MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        setupTextView()
    }

// MARK: - @IBACTIONS
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(number: string(sender))
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        calculator.addOperator(operator: ("  \(string(sender))  "))
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
        calculator.addDecimal(point: string(sender))
    }

// MARK: - PRIVATE FUNC
    private func setupTextView() {
        textView.text = calculator.calculString
        textView.layer.cornerRadius = 25
    }

    private func string(_ sender: UIButton) -> String {
        var number = ""
        if let title = sender.titleLabel?.text {
            number = title
        }
        return number
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
