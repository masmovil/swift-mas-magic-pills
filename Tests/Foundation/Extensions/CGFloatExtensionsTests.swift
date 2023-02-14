import Foundation
import MasMagicPills
import XCTest

class CGFloatExtensionsTests: XCTestCase {
    func test_convert_degrees_to_radianas() {
        let degrees: CGFloat = 90
        let radians: CGFloat = degrees.radians

        XCTAssertEqual(radians, 1.5707963267948966)
    }
}
