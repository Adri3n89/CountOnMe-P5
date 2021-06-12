//
//  Calculator.swift
//  CountOnMe
//
//  Created by Adrien PEREA on 28/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
// swiftlint:disable all

import Foundation
// MARK: - PROTOCOL
protocol CalculatorDelegate {
    // declaration of protocol methods
    func alert(title: String, message: String)
    func setupCalcul(calculString: String)
}

class Calculator {
    // MARK: - VARIABLES
    var delegate: CalculatorDelegate?
    var calculString: String = "" {
        didSet {
            delegate?.setupCalcul(calculString: calculString)
        }
    }

    // MARK: - PRIVATE VARIABLES
    // make an array of strings by splitting the calculString variable
    private var elements: [String] {
        return calculString.split(separator: " ").map { "\($0)" }
    }

    // check the last element of the calcul before make "=" or add operator
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && elements.last?.last != "."
    }

    // check the minimum element in the calcul
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    // check in element a consecutive divide and 0
    private var divideBy0: Bool {
        var dividezero = 0
        if expressionHaveEnoughElement {
            for index in 0...elements.count-2 {
                if let elementDouble = Double(elements[index+1]) {
                    if elements[index] == "÷" && elementDouble == 0 {
                        dividezero += 1
                    }
                }
            }
        }
        return dividezero != 0
    }

    // check if calculString have an index for an element with "=" if it is, calcul already have a result
    private var expressionHaveResult: Bool {
        return calculString.firstIndex(of: "=") != nil
    }

    // check if an element already have a decimal
    private var wrongDecimal: Bool {
        var decimal = 0
        if elements.count > 0 {
            for index in 0...elements.count-1 where elements[index].last == "." {
                decimal += 1
            }
        }
        return decimal != 0
    }

    // MARK: - PRIVATE FUNC
    // format the resultat to show 2 decimals
    private func decimalOrNot(result: Double) -> String {
        var resultFormated = ""
        let decimal = NumberFormatter()
        decimal.minimumFractionDigits = 0
        decimal.maximumFractionDigits = 4
        if let resultString = decimal.string(from: NSNumber(value: result)) {
             resultFormated = resultString
        }
        return resultFormated
    }

    // proceed an operation by checking the operand and the element before and after it and remove them to add the result instead
    private func makeOperation(element: [String], index: Int) -> [String] {
        var element = element
        let left = Double(element[index-1])!
        let operand = element[index]
        let right = Double(element[index+1])!
        var result: Double = 0
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "x": result = left * right
        case "÷": result = left / right
        default: delegate?.alert(title: "Zéro !", message: "Opérateur Inconnu")
        }
        element.removeSubrange(index-1...index+1)
        element.insert("\(result)", at: index-1)
        return element
    }

    // MARK: - FUNCTIONS
    // check different conditions before adding an operator to calculString
    func addOperator(operator: String) {
        if expressionHaveResult {
            calculString = ""
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas commencer par un opérateur !")
        } else if calculString == "" {
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas commencer par un opérateur !")
        } else if divideBy0 {
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas diviser par 0 !")
        } else {
            if expressionIsCorrect {
                calculString.append(`operator`)
            } else {
                delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur !\nCorrigez le calcul !")
            }
        }
    }

    // add operator to calculString and check before if a result exist to clear the calcul before add it
    func addNumber(number: String) {
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }

    // check different conditions before adding a ".'
    func addDecimal(point: String) {
        if calculString == "" {
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas mettre de . ici !")
        } else if elements.last?.contains(".") == true {
            delegate?.alert(title: "Zéro!", message: "Vous avez déja mis un . !")
        } else if elements.last == "x" || elements.last == "+" || elements.last == "-" || elements.last == "÷" {
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas mettre de . ici !")
        } else {
        calculString.append(point)
        }
    }

    // reset the calculString
    func ACButton() {
        calculString = ""
    }

    // delete the last character of the 3 lasts if its an operator
    func deleteButton() {
        // check if the string is empty
        guard calculString.last != nil else {
            return
        }
        // if the expression have result clear the string
        if expressionHaveResult {
            ACButton()
        } else {
            if calculString.last == " " {
                calculString.removeLast(3)
            } else {
                calculString.removeLast()
            }
        }
    }

    // make the operation on calculString and add result to it
    func doCalcul() {
        guard !divideBy0 else {delegate?.alert(title: "Zero!", message: "Vous ne pouvez pas diviser par 0 !")
            return
        }
        guard !wrongDecimal else {delegate?.alert(title: "Zero!", message: "Ajoutez un chiffre après la virgule !")
            return
        }
        let count = elements.count
        if expressionHaveEnoughElement {
            if elements[count-2] == "=" {
                delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas refaire = \nsaisissez un nouveau calcul !")
                return
            }
        }
        guard expressionIsCorrect else {
            delegate?.alert(title: "Zéro!", message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.alert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
            return
        }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            if operationsToReduce.count > 4 {
                if operationsToReduce[1] == "x" || operationsToReduce[1] == "÷" {
                    operationsToReduce = makeOperation(element: operationsToReduce, index: 1)
                } else if operationsToReduce[3] == "x" || operationsToReduce[3] == "÷"{
                    operationsToReduce = makeOperation(element: operationsToReduce, index: 3)
                } else {
                    operationsToReduce = makeOperation(element: operationsToReduce, index: 1)
                }
            } else {
                operationsToReduce = makeOperation(element: operationsToReduce, index: 1)
            }
        }
        if let result = Double(operationsToReduce[0]) {
            calculString.append(" = \(decimalOrNot(result: result))")
        }
    }

}
