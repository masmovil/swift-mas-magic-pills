import Foundation
import MasMagicPills
import XCTest

class IntExtensionsTests: XCTestCase {
    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int).toString, "24")
        XCTAssertEqual((1_024 as Int).toString, "1024")
        XCTAssertNotEqual((1_024 as Int).toString, "10")
    }
}
