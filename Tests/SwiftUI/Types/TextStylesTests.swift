import Foundation
import MasMagicPills
import SwiftUI
import XCTest

class TextStylesTests: XCTestCase {
    func test_create_normal_style() {
        let style = TextStyle(font: Font.system(size: 12),
                              color: .blue,
                              lineHeight: 20,
                              lineSpacing: 4)

        XCTAssertEqual(style.lineSpacing, 4)
        XCTAssertEqual(style.lineHeight, 20)
        XCTAssertEqual(style.alignment, .none)
        XCTAssertEqual(style.textCase, .none)

        XCTAssertEqual(style.textAlignment, .leading)
        XCTAssertEqual(style.uppercased.textCase, .uppercase)
    }

    func test_create_right_aligned_style() {
        let style = TextStyle(font: Font.system(size: 12),
                              color: .blue,
                              lineHeight: 20,
                              lineSpacing: 4,
                              alignment: .right,
                              textCase: .lowercase)

        XCTAssertEqual(style.lineSpacing, 4)
        XCTAssertEqual(style.lineHeight, 20)
        XCTAssertEqual(style.alignment, .right)
        XCTAssertEqual(style.textCase, .lowercase)

        XCTAssertEqual(style.textAlignment, .trailing)
        XCTAssertEqual(style.uppercased.textCase, .uppercase)
    }

    func test_create_center_aligned_style() {
        let style = TextStyle(font: Font.system(size: 12),
                              color: .blue,
                              lineHeight: 20,
                              lineSpacing: 4,
                              alignment: .center)

        XCTAssertEqual(style.lineSpacing, 4)
        XCTAssertEqual(style.lineHeight, 20)
        XCTAssertEqual(style.alignment, .center)
        XCTAssertEqual(style.textCase, .none)

        XCTAssertEqual(style.textAlignment, .center)
        XCTAssertEqual(style.uppercased.textCase, .uppercase)
    }
}
