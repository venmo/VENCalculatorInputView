import XCTest
import Foundation
import CalculatorInputView

class MoneyCalculatorTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = NSLocale(localeIdentifier: "en_US")
        return calc
    }()

    func testAddition() {
        XCTAssertEqual("2", calculator.evaluateExpression("1+1")!)
        XCTAssertEqual("2", calculator.evaluateExpression("1 + 1")!)
        XCTAssertEqual("1001", calculator.evaluateExpression("1 + 1000")!)
    }

    func testSubtraction() {
        XCTAssertEqual("0", calculator.evaluateExpression("1-1")!)
        XCTAssertEqual("9999", calculator.evaluateExpression("10000-1")!)
        XCTAssertEqual("-100", calculator.evaluateExpression("0 - 100")!)

        // Longer dash
        XCTAssertEqual("0", calculator.evaluateExpression("1−1")!)
        XCTAssertEqual("9999", calculator.evaluateExpression("10000−1")!)
        XCTAssertEqual("-100", calculator.evaluateExpression("0 − 100")!)
    }

    func testMultiplication() {
        XCTAssertEqual("4", calculator.evaluateExpression("2*2")!)
        XCTAssertEqual("120", calculator.evaluateExpression("100*1.2")!)
        XCTAssertEqual("800", calculator.evaluateExpression("1000 * 0.8")!)

        XCTAssertEqual("4", calculator.evaluateExpression("2×2")!)
        XCTAssertEqual("120", calculator.evaluateExpression("100×1.2")!)
        XCTAssertEqual("800", calculator.evaluateExpression("1000 × 0.8")!)
    }

    func testDivision() {
        XCTAssertEqual("1", calculator.evaluateExpression("2/2")!)
        XCTAssertEqual("25", calculator.evaluateExpression("100/4")!)
        XCTAssertEqual("0.50", calculator.evaluateExpression("1/2")!)

        XCTAssertEqual("1", calculator.evaluateExpression("2÷2")!)
        XCTAssertEqual("25", calculator.evaluateExpression("100÷4")!)
        XCTAssertEqual("0.50", calculator.evaluateExpression("1÷2")!)
    }

    func testNilForInvalidExpressions() {
        XCTAssertNil(calculator.evaluateExpression("1+++1"))
        XCTAssertNil(calculator.evaluateExpression("++++-12!@#"))
        XCTAssertNil(calculator.evaluateExpression("+"))
        XCTAssertNil(calculator.evaluateExpression("1+"))
    }

    func testDivisionByZero() {
        XCTAssertEqual("0", calculator.evaluateExpression("2÷0")!)
        XCTAssertEqual("0", calculator.evaluateExpression("0÷0")!)
        XCTAssertEqual("0", calculator.evaluateExpression("-2÷0")!)
        XCTAssertEqual("0", calculator.evaluateExpression("-0÷0")!)
    }
}


class MoneyCalculatorFrenchTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = NSLocale(localeIdentifier: "fr_FR")
        return calc
    }()

    func testMultiplication() {
        XCTAssertEqual("120", calculator.evaluateExpression("100*1,2")!)
        XCTAssertEqual("800", calculator.evaluateExpression("1000 * 0,8")!)
    }

    func testDivision() {
        XCTAssertEqual("0,50", calculator.evaluateExpression("1/2")!)
    }
}


class MoneyCalculatorGermanTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = NSLocale(localeIdentifier: "de_DE")
        return calc
    }()

    func testMultiplication() {
        XCTAssertEqual("120", calculator.evaluateExpression("100*1,2")!)
        XCTAssertEqual("800", calculator.evaluateExpression("1000 * 0,8")!)
    }

    func testDivision() {
        XCTAssertEqual("0,50", calculator.evaluateExpression("1/2")!)
    }

    func testBigNumbers() {
        XCTAssertEqual("1.075,01", calculator.evaluateExpression("1.035,01+40")!)
        XCTAssertEqual("5,01", calculator.evaluateExpression("1.040,01-1.035")!)
    }
}


class MoneyCalculatorVietnameTests: XCTestCase {
    func testVietnamese() {
        let calculator = MoneyCalculator()
        calculator.locale = NSLocale(localeIdentifier: "vi_VN")
        XCTAssertEqual("2", calculator.evaluateExpression("1,90")!)
        XCTAssertEqual("1", calculator.evaluateExpression("1,30")!)
        XCTAssertEqual("1", calculator.evaluateExpression("0,90")!)
    }

    func testUS() {
        let calculator = MoneyCalculator()
        calculator.locale = NSLocale(localeIdentifier: "en_US")
        XCTAssertEqual("1.90", calculator.evaluateExpression("1.90")!)
        XCTAssertEqual("1.30", calculator.evaluateExpression("1.30")!)
        XCTAssertEqual("0.90", calculator.evaluateExpression("0.90")!)
    }
}
