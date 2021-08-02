import Foundation
import MasMagicPills
import XCTest

class BoolExtensionsTests: XCTestCase {
    func test_is_false() {
        XCTAssertTrue(false.isFalse)
        XCTAssertFalse(true.isFalse)
    }
}
