import Foundation
import MasMagicPills
import XCTest

class URLComponentsExtensionsTests: XCTestCase {
    let components = URLComponents(string: "http://www.google.com/q?search=white%20vaporeon")!

    func test_subscript_for_queryitems() {
        XCTAssertEqual(components[queryItem: "search"], "white vaporeon")
        XCTAssertNil(components[queryItem: "wawa"])
    }
}
