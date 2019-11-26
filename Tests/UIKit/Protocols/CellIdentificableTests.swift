import XCTest
import Foundation
import MagicPills

class CellIdentificableTests: XCTestCase {
    func test_reuseIdentifier() {
        XCTAssertEqual(ViewWithCellIdentificable.reuseIdentifier, "ViewWithCellIdentificableID")
    }
}

private class ViewWithCellIdentificable: UIView, CellIdentificable { }
