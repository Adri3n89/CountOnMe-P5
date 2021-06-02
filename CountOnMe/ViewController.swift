//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var funcButtons: [UIButton]!
    var calculator: Calculator!

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator = Calculator()
        calculator.delegate = self
        setupTextView()
        // Do any additional setup after loading the view.
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(number: sender.titleLabel!.text!)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.addOperator(operator: " + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.addOperator(operator: " - ")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.doCalcul()
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.addOperator(operator: " x ")
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.addOperator(operator: " ÷ ")
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.ACButton()
    }
    
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        calculator.deleteButton()
    }
    
    @IBAction func tappedDecimalButton(_ sender: UIButton) {
        calculator.addDecimal(point: ".")
    }
    
    func setupTextView() {
        textView.text = calculator.calculString
        textView.layer.cornerRadius = numberButtons[0].frame.height / 2
    }

}

extension ViewController: CalculatorDelegate {
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func setupCalcul(calculString: String) {
        textView.text = calculString
    }
}

