import Foundation
import MasMagicPills
import XCTest

class IntExtensionsTests: XCTestCase {
    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int).stringValue, "24")
        XCTAssertEqual((1_024 as Int).stringValue, "1024")
        XCTAssertNotEqual((1_024 as Int).stringValue, "10")
    }

    func test_int_to_decimal_convertion() {
        XCTAssertEqual((24 as Int).decimalValue, 24)
    }
}
