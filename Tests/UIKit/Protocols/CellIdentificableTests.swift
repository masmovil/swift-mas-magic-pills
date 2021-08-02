import Foundation
import MasMagicPills
import XCTest

class CellIdentificableTests: XCTestCase {
    func test_reuseIdentifier() {
        XCTAssertEqual(ViewWithCellIdentificable.reuseIdentifier, "ViewWithCellIdentificableID")
    }
}

private class ViewWithCellIdentificable: UIView, CellIdentificable { }
