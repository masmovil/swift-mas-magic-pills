import Foundation
import MasMagicPills
import XCTest

class StringExtensionsValuesTests: XCTestCase {
    func test_bool_value() {
        XCTAssertEqual("true".boolValue, true)
        XCTAssertEqual("True".boolValue, true)
        XCTAssertEqual("yes".boolValue, true)
        XCTAssertEqual("Yes".boolValue, true)
        XCTAssertEqual("1".boolValue, true)

        XCTAssertEqual("false".boolValue, false)
        XCTAssertEqual("False".boolValue, false)
        XCTAssertEqual("no".boolValue, false)
        XCTAssertEqual("No".boolValue, false)
        XCTAssertEqual("0".boolValue, false)

        XCTAssertNil("".boolValue)
        XCTAssertNil("wawa".boolValue)
    }

    func test_internet_url_value() {
        XCTAssertNil("".internetUrlValue)
        XCTAssertEqual("http://www.google.com".internetUrlValue, URL(string: "http://www.google.com"))
    }

    func test_url_value() {
        XCTAssertNil("".urlValue)
        XCTAssertEqual("http://www.google.com".urlValue, URL(string: "http://www.google.com"))
    }

    func test_date_value() {
        XCTAssertEqual("2018".date(),
                       "01/01/2018 00:00".date())
        XCTAssertEqual("2015-05-20T12:00:00.000Z".date(),
                       "20/05/2015 12:00".date())
        XCTAssertEqual("2018-12-25".date(),
                       "25/12/2018 00:00".date())

        XCTAssertNil("".date())
        XCTAssertNil("wawa".date())
    }

    func test_utf8_convertion() {
        XCTAssertEqual("hola".dataUTF8.stringUTF8, "hola")
    }

    func test_html_value() {
        let text1 = "hola"
        let text2 = "chau"
        let html1 = text1.htmlValue(fontSize: 12)
        let html2 = text2.htmlValue(fontSize: 14, fontFamily: "Arial")

        let attrString1 = try? NSAttributedString(data: html1.dataUTF8,
                                                  options: [.documentType: NSAttributedString.DocumentType.html],
                                                  documentAttributes: nil)
        let attrString2 = try? NSAttributedString(data: html2.dataUTF8,
                                                  options: [.documentType: NSAttributedString.DocumentType.html],
                                                  documentAttributes: nil)
        XCTAssertEqual(attrString1?.string, text1)
        XCTAssertTrue(html1.contains("font-size: 12"))

        XCTAssertEqual(attrString2?.string, text2)
        XCTAssertTrue(html2.contains("font-size: 14"))
        XCTAssertTrue(html2.contains("font-family: Arial"))
    }
}
