import Foundation
import MasMagicPills
import XCTest

class URLExtensionsTests: XCTestCase {
    func test_appendingFragment() {
        let url = URL(string: "http://aaa.com")!

        let newUrl = url.appendingFragment("fasf")

        XCTAssertEqual(newUrl.absoluteString, "http://aaa.com#fasf")
    }

    func test_appendingItems() throws {
        let url = URL(string: "http://aaa.com")!

        let newUrl = try url.appendingItems(items: [.init(name: "fff", value: "aaaa")])

        XCTAssertEqual(newUrl.absoluteString, "http://aaa.com?fff=aaaa")
    }

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

    func test_clicktocall_destination() {
        XCTAssertEqual("tel:685685685".urlValue?.clickToCallDestination, "685685685")
        XCTAssertEqual("wawa:fasf".urlValue?.clickToCallDestination, nil)
    }

    func test_mailto_url() {
        XCTAssertEqual(URL(string: "mailto:ssss@ssss.com")?.isMailTo, true)
        XCTAssertEqual(URL(string: "mailto:ssss@ssss.com?subject=Hi")?.isMailTo, true)
        XCTAssertEqual(URL(string: "tel:+34687687687")?.isMailTo, false)
        XCTAssertEqual(URL(string: "mailto:asfasf.com")?.isMailTo, false)
        XCTAssertEqual(URL(string: "mailto:124124")?.isMailTo, false)
    }

    func test_mailto_destination() {
        XCTAssertEqual("mailto:sss@ssss.com?subject=hi".urlValue?.mailToDestination, "sss@ssss.com")
        XCTAssertEqual("mailto:sss@ssss.com".urlValue?.mailToDestination, "sss@ssss.com")
        XCTAssertEqual("fafa:sss@ssss.com".urlValue?.mailToDestination, nil)
    }

    func test_resourceSpecifier() {
        XCTAssertEqual("https://www.google.com".urlValue?.resourceSpecifier, "//www.google.com")
        XCTAssertEqual("mailto:sss@ssss.com".urlValue?.resourceSpecifier, "sss@ssss.com")
    }

    func test_check_is_reachable_for_two_urls() async {
        let validURL = "https://code.jquery.com/jquery-3.7.1.min.js".urlValue!
        let wrongURL = "https://code.jquery.com/jquery-HAKUNA-MATATA.min.js".urlValue!

        let resultTrue = await validURL.checkIsReachableOnInternet()
        let resultFalse = await wrongURL.checkIsReachableOnInternet()

        XCTAssertTrue(resultTrue)
        XCTAssertFalse(resultFalse)
    }

    func test_check_is_reachable_for_an_array_of_urls() async {
        let validURL = "https://code.jquery.com/jquery-3.7.1.min.js".urlValue!
        let wrongURL = "https://code.jquery.com/jquery-HAKUNA-MATATA.min.js".urlValue!

        let array = [validURL, validURL, wrongURL, wrongURL, validURL]
        let filteredArray = await array.filterUnreachableUrls()

        XCTAssertEqual(filteredArray.count, 3)
    }
}
