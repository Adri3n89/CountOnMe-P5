//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        calculator = Calculator()
    }

    func testGiven4Plus2Substract4Multiplicate2Divide4_WhenDoCalcul_ThenResult4() {
        calculator.addNumber(number: "4")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " - ")
        calculator.addNumber(number: "4")
        calculator.addOperator(operator: " x ")
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " ÷ ")
        calculator.addNumber(number: "4")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "4 + 2 - 4 x 2 ÷ 4 = 4")
    }

    func testGiven0AddDecimalAnd9AndXAnd2_WhenDoCalcul_ThenEqual1Point8() {
        calculator.addNumber(number: "0")
        calculator.addDecimal(point: ".")
        calculator.addNumber(number: "9")
        calculator.addOperator(operator: " x ")
        calculator.addNumber(number: "2")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "0.9 x 2 = 1.8")
    }

    func testGiven2Plus3MultipliateBy3_WhenPushDelete_ThenShow2Plus3Multiplate() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "3")
        calculator.addOperator(operator: " x ")
        calculator.addNumber(number: "3")

        calculator.deleteButton()

        XCTAssertEqual(calculator.calculString, "2 + 3 x ")
    }

    func testGivenOneAddOperatorPlusAndTwoEqual3_WhenAdd1_ThenShow1() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")
        calculator.doCalcul()

        calculator.addNumber(number: "1")

        XCTAssertEqual(calculator.calculString, "1")
    }

    func testGiven2Plus3MultipliateBy3_WhenPushAC_ThenShowEmptyString() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "3")
        calculator.addOperator(operator: " x ")
        calculator.addNumber(number: "3")

        calculator.ACButton()

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGivenOneAddOperatorPlusAndTwoAndEqual_WhenPutDelete_ThenShowEmptyString() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")
        calculator.doCalcul()

        calculator.deleteButton()

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGiven2Plus3Multipliate_WhenPushDelete_ThenShow2Plus3() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "3")
        calculator.addOperator(operator: " x ")

        calculator.deleteButton()

        XCTAssertEqual(calculator.calculString, "2 + 3")
    }

    func testGiven2Divide0_WhenPushEqual_ThenShow2Divide0() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " ÷ ")
        calculator.addNumber(number: "0")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "2 ÷ 0")
    }

    func testGiven2Divide0_WhenPushOperator_ThenShow2Divide0() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " ÷ ")
        calculator.addNumber(number: "0")

        calculator.addOperator(operator: " + ")

        XCTAssertEqual(calculator.calculString, "2 ÷ 0")
    }

    func testGivenEmptyCalcul_WhenPushFirstPlus_ThenShowEmptyString() {
        calculator.addOperator(operator: " + ")

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGivenOneAddOperatorPlusAndTwoEqual3_WhenAddPlus_ThenShowEmptyString() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")
        calculator.doCalcul()

        calculator.addOperator(operator: " + ")

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGivenOneAddOperatorPlus_WhenAddPlus_ThenShow1Plus() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")

        calculator.addOperator(operator: " + ")

        XCTAssertEqual(calculator.calculString, "1 + ")
    }

    func testGivenEmptyString_WhenDelete_ThenShowEmptyString() {
        calculator.deleteButton()

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGiven0Plus0AddDecimal_WhenDoCalcul_ThenShow0Plus0Point() {
        calculator.addNumber(number: "0")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "0")
        calculator.addDecimal(point: ".")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "0 + 0.")
    }

    func testGivenOneAddOperatorPlusAndTwoEqual3_WhenDoCalcul_ThenShowResult() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")
        calculator.doCalcul()

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "1 + 2 = 3")
    }

    func testGivenEmptyCalcul_WhenAddDecimal_ThenShowEmptyCalcul() {
        calculator.addDecimal(point: ".")

        XCTAssertEqual(calculator.calculString, "")
    }

    func testGiven1AddDecimal0_WhenAddDecimal_ThenShow1Point0() {
        calculator.addNumber(number: "1")
        calculator.addDecimal(point: ".")
        calculator.addNumber(number: "0")

        calculator.addDecimal(point: ".")

        XCTAssertEqual(calculator.calculString, "1.0")
    }

    func testGivenOneAddOperatorPlus_WhenAddDecimal_ThenShow1Plus() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")

        calculator.addDecimal(point: ".")

        XCTAssertEqual(calculator.calculString, "1 + ")
    }

    func testGiven2Multipliate3Plus2_WhenDoCalcul_ShowResult8() {
        calculator.addNumber(number: "2")
        calculator.addOperator(operator: " x ")
        calculator.addNumber(number: "3")
        calculator.addOperator(operator: " + ")
        calculator.addNumber(number: "2")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "2 x 3 + 2 = 8")
    }

    func testGivenOneAddOperatorPlus_WhenDoCalcul_ThenShow1Plus() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " + ")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "1 + ")
    }

    func testGivenOne_WhenDoCalcul_ThenShow1() {
        calculator.addNumber(number: "1")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "1")
    }

    func testGiven1AddAAdd1_WhenDoCalcul_ThenShow1A1() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operator: " A ")
        calculator.addNumber(number: "1")

        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "1 A 1 = 0")
    }

    func testGivenEmptyCalcul_WhenDoCalcul_ThenShowAlertAndDoNothing() {
        calculator.doCalcul()

        XCTAssertEqual(calculator.calculString, "")
    }

}
