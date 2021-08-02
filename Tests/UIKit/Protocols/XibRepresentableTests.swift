import Foundation
import MasMagicPills
import XCTest

class XibRepresentableTests: XCTestCase {
    func test_xib_name() {
        XCTAssertEqual(ViewWithRepresentableXib.xibName, "ViewWithRepresentableXib")
    }
}

private class ViewWithRepresentableXib: UIView { }
