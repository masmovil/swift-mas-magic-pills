import Foundation
import MasMagicPills
import SwiftUI
import XCTest

class ColorExtensionsTests: XCTestCase {
    func test_init_from_hex() throws {
        XCTAssertEqual(try Color(hex: "FFFFFF"), .white)
        XCTAssertEqual(try Color(hex: "#FFFFFF"), .white)
        XCTAssertThrowsError(try Color(hex: "#kkkk"))
        XCTAssertThrowsError(try Color(hex: "🤷"))
    }
}
