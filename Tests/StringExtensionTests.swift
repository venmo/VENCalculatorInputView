import XCTest
import Foundation
import CalculatorInput

class StringExtensionTests: XCTestCase {
    func testWhitespace() {
        let result = NSString(string: "foo     bar\n           ").ven_stringByReplacingCharacters(in: CharacterSet.whitespacesAndNewlines, with: "")
        XCTAssertEqual("foobar", result)
    }

    func testCustomCharacterSet() {
        let characterSet = CharacterSet(charactersIn: "0123456789-/*.+").inverted
        let result = NSString(string: "1+1(&^!@#+1foobar").ven_stringByReplacingCharacters(in: characterSet, with: "")
        XCTAssertEqual("1+1+1", result)
    }
}
