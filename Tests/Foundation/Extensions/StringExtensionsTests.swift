import Foundation
import MasMagicPills
import XCTest

class StringExtensionsTests: XCTestCase {
    /*func test_localized() {
     let bundle = Bundle(for: StringExtensionsTests.self)
     let tableName = "LocalizedSample"
     let localizedExample = NSLocalizedString("sample_text", tableName: tableName, bundle: bundle, comment: "")

     XCTAssertEqual(localizedExample, "Sample Text")
     XCTAssertEqual("sample_text".localized(bundle: bundle, tableName: tableName), localizedExample)
     XCTAssertEqual("not_found".localized(bundle: bundle, tableName: tableName), "**not_found**")
     }*/

    func test_separating() {
        XCTAssertEqual("HOLA".separating(every: 1), "H O L A")
        XCTAssertEqual("ARGENTINA".separating(every: 3), "ARG ENT INA")
        XCTAssertEqual("🍆🎄".separating(every: 1, with: "💦"), "🍆💦🎄")
    }

    func test_is_valid_for_phone_dialer() {
        XCTAssertTrue("2414124124".isValidForPhoneDialer)
        XCTAssertTrue("+44(2)841-412-4124".isValidForPhoneDialer)
        XCTAssertFalse("2414hh124124".isValidForPhoneDialer)
        XCTAssertFalse("24aa14 12 4124".isValidForPhoneDialer)
        XCTAssertTrue("#21*412".isValidForPhoneDialer)
    }
}
