import Foundation
import MasMagicPills
import XCTest
#if canImport(UIKit)
import UIKit

class CellIdentificableTests: XCTestCase {
    func test_reuseIdentifier() {
        XCTAssertEqual(ViewWithCellIdentificable.reuseIdentifier, "ViewWithCellIdentificableID")
    }
}

private class ViewWithCellIdentificable: UIView, CellIdentificable { }
#endif
