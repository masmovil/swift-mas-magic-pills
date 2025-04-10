import Foundation
import MasMagicPills
import XCTest
#if canImport(UIKit)
import UIKit

class UIStackViewExtensionsTests: XCTestCase {
    func test_add_arranged_subviews() {
        let stack = UIStackView()
        stack.addArrangedSubviews([UIView(), UIView()])
        XCTAssertEqual(stack.arrangedSubviews.count, 2)
    }

    func test_remove_arranged_subviews() {
        let stack = UIStackView()
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(UIView())
        stack.removeAllArrangedSubviews()
        XCTAssert(stack.arrangedSubviews.isEmpty)
    }
}
#endif
