import XCTest
import Foundation
import CalculatorInput

class MoneyCalculatorTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = Locale(identifier: "en_US")
        return calc
    }()

    func testAddition() {
        XCTAssertEqual("2.00", calculator.evaluateExpression("1+1")!)
        XCTAssertEqual("2.00", calculator.evaluateExpression("1 + 1")!)
        XCTAssertEqual("1,001.00", calculator.evaluateExpression("1 + 1000")!)
    }

    func testSubtraction() {
        XCTAssertEqual("0.00", calculator.evaluateExpression("1-1")!)
        XCTAssertEqual("9,999.00", calculator.evaluateExpression("10000-1")!)
        XCTAssertEqual("-100.00", calculator.evaluateExpression("0 - 100")!)

        // Longer dash
        XCTAssertEqual("0.00", calculator.evaluateExpression("1−1")!)
        XCTAssertEqual("9,999.00", calculator.evaluateExpression("10000−1")!)
        XCTAssertEqual("-100.00", calculator.evaluateExpression("0 − 100")!)
    }

    func testMultiplication() {
        XCTAssertEqual("4.00", calculator.evaluateExpression("2*2")!)
        XCTAssertEqual("120.00", calculator.evaluateExpression("100*1.2")!)
        XCTAssertEqual("800.00", calculator.evaluateExpression("1000 * 0.8")!)

        XCTAssertEqual("4.00", calculator.evaluateExpression("2×2")!)
        XCTAssertEqual("120.00", calculator.evaluateExpression("100×1.2")!)
        XCTAssertEqual("800.00", calculator.evaluateExpression("1000 × 0.8")!)
    }

    func testDivision() {
        XCTAssertEqual("1.00", calculator.evaluateExpression("2/2")!)
        XCTAssertEqual("25.00", calculator.evaluateExpression("100/4")!)
        XCTAssertEqual("0.50", calculator.evaluateExpression("1/2")!)

        XCTAssertEqual("1.00", calculator.evaluateExpression("2÷2")!)
        XCTAssertEqual("25.00", calculator.evaluateExpression("100÷4")!)
        XCTAssertEqual("0.50", calculator.evaluateExpression("1÷2")!)
    }

    func testNilForInvalidExpressions() {
        XCTAssertNil(calculator.evaluateExpression("1+++1"))
        XCTAssertNil(calculator.evaluateExpression("++++-12!@#"))
        XCTAssertNil(calculator.evaluateExpression("+"))
        XCTAssertNil(calculator.evaluateExpression("1+"))
    }

    func testDivisionByZero() {
        XCTAssertEqual("0.00", calculator.evaluateExpression("2÷0")!)
        XCTAssertEqual("0.00", calculator.evaluateExpression("0÷0")!)
        XCTAssertEqual("0.00", calculator.evaluateExpression("-2÷0")!)
        XCTAssertEqual("0.00", calculator.evaluateExpression("-0÷0")!)
    }

    func testAllowNegativeNumbers() {
        XCTAssertEqual("1.00", calculator.evaluateExpression("2-1")!)
        XCTAssertEqual("0.00", calculator.evaluateExpression("0-100", allowNegativeResult: false)!)
    }

    func testDecimalRounding() {
        XCTAssertEqual("1.44", calculator.evaluateExpression("1.445"))
        XCTAssertEqual("2.44", calculator.evaluateExpression("2.445"))
    }
}


class MoneyCalculatorFrenchTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = Locale(identifier: "fr_FR")
        return calc
    }()

    func testMultiplication() {
        XCTAssertEqual("120,00", calculator.evaluateExpression("100*1,2")!)
        XCTAssertEqual("800,00", calculator.evaluateExpression("1000 * 0,8")!)
    }

    func testDivision() {
        XCTAssertEqual("0,50", calculator.evaluateExpression("1/2")!)
    }
}


class MoneyCalculatorGermanTests: XCTestCase {
    let calculator: MoneyCalculator = {
        let calc = MoneyCalculator()
        calc.locale = Locale(identifier: "de_DE")
        return calc
    }()

    func testMultiplication() {
        XCTAssertEqual("120,00", calculator.evaluateExpression("100*1,2")!)
        XCTAssertEqual("800,00", calculator.evaluateExpression("1000 * 0,8")!)
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
        calculator.locale = Locale(identifier: "vi_VN")
        XCTAssertEqual("2", calculator.evaluateExpression("1,90")!)
        XCTAssertEqual("1", calculator.evaluateExpression("1,30")!)
        XCTAssertEqual("1", calculator.evaluateExpression("0,90")!)
        XCTAssertEqual("1.000", calculator.evaluateExpression("100+900")!)
    }

    func testUS() {
        let calculator = MoneyCalculator()
        calculator.locale = Locale(identifier: "en_US")
        XCTAssertEqual("1.90", calculator.evaluateExpression("1.90")!)
        XCTAssertEqual("1.30", calculator.evaluateExpression("1.30")!)
        XCTAssertEqual("0.90", calculator.evaluateExpression("0.90")!)
    }
}
