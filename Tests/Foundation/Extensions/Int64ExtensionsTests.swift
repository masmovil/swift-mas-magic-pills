import Foundation
import MasMagicPills
import XCTest

class Int64ExtensionsTests: XCTestCase {
    func test_hepers_for_giga_and_mega() {
        let sixGigaBytes = Int64.bytes(gibibytes: 6)
        XCTAssertEqual(sixGigaBytes, 6 * 1_024 * 1_024 * 1_024)

        let twentyFiveMegaBytes = Int64.bytes(mebibytes: 25)
        XCTAssertEqual(twentyFiveMegaBytes, 25 * 1_024 * 1_024)
    }

    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int64).stringValue, "24")
        XCTAssertEqual((1_024 as Int64).stringValue, "1024")
        XCTAssertNotEqual((1_024 as Int64).stringValue, "10")
    }
}
