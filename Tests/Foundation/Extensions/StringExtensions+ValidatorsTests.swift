import Foundation
import MasMagicPills
import XCTest

class StringExtensionsValidatorsTests: XCTestCase {
    func test_valid_internet_url() {
        XCTAssertTrue("itms://itunes.apple.com/es/app/xxxx/id123132156465456456".isValidInternetUrl)
        XCTAssertTrue("http://www.google.com".isValidInternetUrl)
        XCTAssertFalse("wawawa".isValidInternetUrl)
        XCTAssertFalse("".isValidInternetUrl)
    }

    func test_is_valid_email() {
        XCTAssertTrue("wawa@wewe.com".isValidEmail)
        XCTAssertTrue("hola@bq.com".isValidEmail)
    }

    func test_is_not_valid_email() {
        XCTAssertFalse("chau".isValidEmail)
    }

    func test_is_valid_spanish_phone() {
        XCTAssertTrue("687687687".isValidSpanishPhone)
        XCTAssertTrue("787687687".isValidSpanishPhone)
        XCTAssertTrue("875258855".isValidSpanishPhone)
        XCTAssertTrue("987687687".isValidSpanishPhone)
        XCTAssertTrue("+34687687687".isValidSpanishPhone)
        XCTAssertTrue("34787687687".isValidSpanishPhone)
        XCTAssertTrue("0034987687687".isValidSpanishPhone)
        XCTAssertTrue("034687687687".isValidSpanishPhone)
        XCTAssertTrue("+34 687 687 687".isValidSpanishPhone)
    }

    func test_is_valid_color() {
        XCTAssertTrue("#C0C0C0".isValidHexColor)
        XCTAssertTrue("#00FF06".isValidHexColor)
        XCTAssertTrue("#ffffff".isValidHexColor)
        XCTAssertTrue("#ffffff".isValidHexColor)
        XCTAssertTrue("#fff".isValidHexColor)
        XCTAssertFalse("#ff".isValidHexColor)
        XCTAssertFalse("#fffffff".isValidHexColor)
        XCTAssertFalse("#lkaslfs".isValidHexColor)
    }

    func test_is_not_valid_spanish_phone() {
        XCTAssertFalse("587687687".isValidSpanishPhone)
        XCTAssertFalse("124".isValidSpanishPhone)
        XCTAssertFalse("kkk".isValidSpanishPhone)
    }

    func test_removing_spanish_country_code() {
        XCTAssertEqual("+34 687 687 687".removingSpanishCountryCode, "687687687")
        XCTAssertEqual("0034687687687".removingSpanishCountryCode, "687687687")
        XCTAssertEqual("034687687687".removingSpanishCountryCode, "687687687")
        XCTAssertEqual("34687687687".removingSpanishCountryCode, "687687687")
        XCTAssertEqual("+34687687687".removingSpanishCountryCode, "687687687")
        XCTAssertEqual("email@mail.com".removingSpanishCountryCode, "email@mail.com")
    }

    func test_is_valid_nif() {
        XCTAssertTrue("01234567L".isValidNIF)
        XCTAssertTrue("11234567X".isValidNIF)
        XCTAssertTrue("21234567R".isValidNIF)
        XCTAssertTrue("12345678Z".isValidNIF)
        XCTAssertTrue("05446767E".isValidNIF)
    }

    func test_is_not_valid_nif() {
        XCTAssertFalse("05446767F".isValidNIF)
        XCTAssertFalse("kkk".isValidNIF)
        XCTAssertFalse("".isValidNIF)
    }

    func test_is_valid_nie() {
        XCTAssertTrue("X1234567L".isValidNIE)
        XCTAssertTrue("Y1234567X".isValidNIE)
        XCTAssertTrue("Z1234567R".isValidNIE)
    }

    func test_is_not_valid_nie() {
        XCTAssertFalse("X1234567X".isValidNIE)
        XCTAssertFalse("Y1234567L".isValidNIE)
        XCTAssertFalse("kkk".isValidNIE)
        XCTAssertFalse("".isValidNIE)
    }
}
