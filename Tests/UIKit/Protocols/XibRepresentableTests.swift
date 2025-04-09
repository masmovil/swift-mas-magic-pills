import Foundation
import MasMagicPills
import XCTest
#if canImport(UIKit)
import UIKit

class XibRepresentableTests: XCTestCase {
    func test_xib_name() {
        XCTAssertEqual(ViewWithRepresentableXib.xibName, "ViewWithRepresentableXib")
    }
}

private class ViewWithRepresentableXib: UIView { }
#endif
