import XCTest
import Foundation
import CalculatorInputView

class StringExtensionTests: XCTestCase {
    func testWhitespace() {
        let result = NSString(string: "foo     bar\n           ").ven_stringByReplacingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet(), withString: "")
        XCTAssertEqual("foobar", result)
    }

    func testCustomCharacterSet() {
        let characterSet = NSCharacterSet(charactersInString: "0123456789-/*.+").invertedSet
        let result = NSString(string: "1+1(&^!@#+1foobar").ven_stringByReplacingCharactersInSet(characterSet, withString: "")
        XCTAssertEqual("1+1+1", result)
    }
}
