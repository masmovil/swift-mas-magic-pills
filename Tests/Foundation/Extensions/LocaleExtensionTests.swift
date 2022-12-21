import Foundation
import MasMagicPills
import XCTest

class LocaleExtensionTests: XCTestCase {
    func test_locales() {
        XCTAssertEqual(Locale.englishUSA.identifier, "en_US")
        XCTAssertEqual(Locale.englishUnitedKingdom.identifier, "en_GB")
        XCTAssertEqual(Locale.spanishSpain.identifier, "es_ES")
        XCTAssertEqual(Locale.spanishArgentine.identifier, "es_AR")
        XCTAssertEqual(Locale.basqueSpain.identifier, "eu_ES")
        XCTAssertEqual(Locale.catalanSpain.identifier, "ca_ES")
        XCTAssertEqual(Locale.posix.identifier, "en_US_POSIX")
    }
}
