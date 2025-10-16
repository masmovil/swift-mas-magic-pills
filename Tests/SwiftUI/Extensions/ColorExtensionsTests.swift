import Foundation
import MasMagicPills
import SwiftUI
import XCTest

class ColorExtensionsTests: XCTestCase {
    func test_init_from_optional_hex() throws {
        XCTAssertEqual(Color(hex: "ffffff" as String?), .white)
        XCTAssertNil(Color(hex: nil))
        XCTAssertNil(Color(hex: "asfhjasas" as String?))
    }

    func test_init_from_hex() throws {
        XCTAssertEqual(try Color(hex: "FFFFFF"), .white)
        XCTAssertEqual(try Color(hex: "#FFFFFF"), .white)
        XCTAssertThrowsError(try Color(hex: "#kkkk"))
        XCTAssertThrowsError(try Color(hex: "🤷"))
    }
}
