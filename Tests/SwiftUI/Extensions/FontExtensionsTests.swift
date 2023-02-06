import Foundation
import MasMagicPills
import SwiftUI
import XCTest

class FontExtensionsTests: XCTestCase {
    func test_existscustomFont() {
        #if !os(macOS) && !os(watchOS)
        XCTAssertEqual(Font.existsCustomFont("Pepe"), false)
        XCTAssertEqual(Font.existsCustomFont("Avenir-Roman"), true)
        #else
        XCTAssertEqual(Font.existsCustomFont("Pepe"), nil)
        #endif
    }
}
