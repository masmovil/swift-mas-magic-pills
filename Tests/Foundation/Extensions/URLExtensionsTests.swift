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

    func test_clicktocall_url() {
        XCTAssertEqual(URL(string: "tel:685685685")?.isClickToCall, true)
        XCTAssertEqual(URL(string: "tel:sfafsaf")?.isClickToCall, false)
        XCTAssertEqual(URL(string: "tel:+34687687687")?.isClickToCall, true)
        XCTAssertEqual(URL(string: "tel:asfasf.com")?.isClickToCall, false)
        XCTAssertEqual(URL(string: "wawa:asfasf.com")?.isClickToCall, false)
    }

    func test_mailto_url() {
        XCTAssertEqual(URL(string: "mailto:ssss@ssss.com")?.isMailto, true)
        XCTAssertEqual(URL(string: "tel:+34687687687")?.isMailto, false)
        XCTAssertEqual(URL(string: "mailto:asfasf.com")?.isMailto, false)
        XCTAssertEqual(URL(string: "mailto:124124")?.isMailto, false)
    }
}
