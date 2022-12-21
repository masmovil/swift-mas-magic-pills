import Foundation
import MasMagicPills
import XCTest

class TimeZoneExtensionsTests: XCTestCase {
    func test_timeZones() {
        let referenceDate = Date(formattedDate: "2019-12-13T10:48:00Z", timeZone: .utc)!
        let formatter = DateFormatter()
        formatter.dateFormat = "Z"

        let offsets = TimeZone.allCases
            .map { timeZone -> String in
                formatter.timeZone = timeZone
                return formatter.string(from: referenceDate)
            }

        let identifiers = TimeZone.allCases
            .map { $0.identifier }

        // Check if we cover all offsets with all locales:
        XCTAssertEqual(offsets.unique.sorted(),
                       ["+0000", "+0100", "+0200", "+0300", "+0330", "+0400", "+0430", "+0500", "+0530", "+0545", "+0600",
                        "+0630", "+0700", "+0800", "+0845", "+0900", "+0930", "+1000", "+1030", "+1100", "+1200", "+1300",
                        "+1345", "+1400", "-0100", "-0200", "-0300", "-0330", "-0400", "-0500", "-0600", "-0700", "-0800",
                        "-0900", "-0930", "-1000", "-1100"])

        // Check if the amount of identifier are uniques:
        XCTAssertEqual(identifiers.unique.count,
                       TimeZone.allCases.count)
    }

    func test_utc() {
        let utc = TimeZone.utc

        XCTAssertEqual(utc.identifier, TimeZone.gmt.identifier)
    }
}
