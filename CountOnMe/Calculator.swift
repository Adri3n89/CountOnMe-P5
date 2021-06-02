//
//  Calculator.swift
//  CountOnMe
//
//  Created by Adrien PEREA on 28/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func alert(title: String, message: String)
    func setupCalcul(calculString: String)
}

class Calculator {
    var delegate: CalculatorDelegate?

//    init(delegate: CalculatorDelegate) {
//        self.delegate = delegate
//    }
    
    var calculString: String = "" {
        didSet {
            delegate?.setupCalcul(calculString: calculString)
        }
    }

    var elements: [String] {
        return calculString.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && elements.last != ","
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x" && elements.last?.last != "."
    }
    
    var divideBy0: Bool {
        var dividezero = 0
        if elements.count > 2 {
            for index in 0...elements.count-2 {
                if elements[index] == "÷" && elements[index+1] == "0" {
                    dividezero += 1
                }
            }
        }
        return dividezero != 0
    }


    var expressionHaveResult: Bool {
        return calculString.firstIndex(of: "=") != nil
    }
    
    var wrongDecimal: Bool {
        var decimal = 0
        if elements.count > 0 {
            for index in 0...elements.count-1 {
                if elements[index].last == "." {
                    decimal += 1
                }
            }
        }
        return decimal != 0
    }
    
    func addOperator(operator: String) {
        if expressionHaveResult {
            calculString = ""
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas commencer par un opérateur !")
        }
        if calculString == "" {
            delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas commencer par un opérateur !")
        } else {
            if canAddOperator {
                calculString.append(`operator`)
            } else {
                delegate?.alert(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur !\nCorrigez le calcul !")
            }
        }
    }
    
    func addNumber(number: String) {
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }
    
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
    
    func ACButton() {
        calculString = ""
    }
    
    func deleteButton() {
        guard calculString.last != nil else {
            return
        }
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
    
    private func decimalOrNot(result: Double) -> String {
        let decimal = NumberFormatter()
        decimal.minimumFractionDigits = 0
        decimal.maximumFractionDigits = 2
        return decimal.string(from: NSNumber(value: result))!
    }
    
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
                    break
        }
        element.remove(at: index-1)
        element.remove(at: index-1)
        element.remove(at: index-1)
        element.insert("\(result)", at: index-1)
        return element
    }
    
    func doCalcul() {
        guard !divideBy0 else {delegate?.alert(title: "Zero!", message: "Vous ne pouvez pas diviser par 0 !")
            return
        }
        guard !wrongDecimal else {delegate?.alert(title: "Zero!", message: "Ajoutez un chiffre après la virgule !")
            return
        }
        let count = elements.count
        if elements.count > 2 {
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
        calculString.append(" = \(decimalOrNot(result: Double(operationsToReduce.first!)!))")
    }

}
