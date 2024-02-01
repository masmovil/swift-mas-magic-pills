import Foundation
import MasMagicPills
import XCTest

class StringExtensionsRangesTests: XCTestCase {
    func test_first_range_ocurrence() {
        let text = "hola chau"

        XCTAssertEqual(text.firstRangeOcurrence("hola"), NSRange(location: 0, length: 4))
        XCTAssertEqual(text.firstRangeOcurrence("chau"), NSRange(location: 5, length: 4))
        XCTAssertNil(text.firstRangeOcurrence("adios"))
    }

    func test_ocurrences_ranges() {
        let ocurrences = "hola hola, que tal?".ocurrencesRanges("hola")

        XCTAssertEqual(ocurrences, [NSRange(location: 0, length: 4), NSRange(location: 5, length: 4)])
    }

    func test_bodyRange() {
        XCTAssertEqual("hola".bodyRange, NSRange(location: 0, length: 4))
        XCTAssertEqual("ho".bodyRange, NSRange(location: 0, length: 2))
    }

    func test_nsRange_of_string() {
        XCTAssertNil("hola".nsRange(of: "chau"))
        XCTAssertEqual("hola".nsRange(of: "la"), NSRange(location: 2, length: 2))
    }
}
