import Foundation
import MasMagicPills
import XCTest

class StringExtensionsRegexTests: XCTestCase {
    func test_satisfies_regex() {
        XCTAssertTrue("X1234567X".satisfiesRegex("[XYZ][0-9]{7}[0-9A-Z]"))
        XCTAssertTrue("X1234567X".satisfiesRegex("^[xyzXYZ]{1}[0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKET]{1}$"))
        XCTAssertTrue("C12452341".satisfiesRegex("^([ABCDEFGHJKLMNPQRSUVW]{1})([0-9A-J]{8})$"))
        XCTAssertTrue("85731245-Z".satisfiesRegex("^([0-9]{8})([-/]{0,1})([a-zA-Z])$"))
    }

    func test_replacing_regex_matches() {
        XCTAssertEqual(try? "+851 124 124 124".replacingRegexMatches(of: "\\+[0-9]{1,3}\\ ", with: ""), "124 124 124")
        XCTAssertEqual(try? "+124 918918918".replacingRegexMatches(of: "\\+[0-9]{1,3}\\ ", with: "☎: "), "☎: 918918918")
    }
}
