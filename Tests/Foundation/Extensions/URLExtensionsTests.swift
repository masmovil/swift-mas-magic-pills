import Foundation
import MasMagicPills
import XCTest

class URLExtensionsTests: XCTestCase {
    func test_comparable() {
        let url1 = URL(string: "http://aaa.com")!
        let url2 = URL(string: "http://bbb.com")!

        XCTAssertTrue(url1 < url2)
        XCTAssertFalse(url1 > url2)
    }

    func test_lowercased() {
        let url1 = URL(string: "http://AAA.com")!
        let url2 = URL(string: "http://aaa.com")!

        XCTAssertNotEqual(url1, url2)
        XCTAssertEqual(url1.lowercased(), url2.lowercased())
    }
}
