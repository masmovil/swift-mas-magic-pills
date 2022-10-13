import Foundation
import MasMagicPills
import XCTest

class CalendarExtensionsTests: XCTestCase {
    func test_localized_calendars() {
        // Madrid (Spain)
        
        let date = Date(formattedDate: "2022-10-13T01:00:00Z", timeZone: .utc)!
        let startDayDate = Date(formattedDate: "2022-10-12T22:00:00Z", timeZone: .utc)!
        let endDayDate = Date(formattedDate: "2022-10-13T21:59:59Z", timeZone: .utc)!
        
        XCTAssertTrue(Calendar.spainMadrid.allDatesAreOnSameDay(dates: date, startDayDate, endDayDate))
    }
    
    func test_is_on_the_first_days_from_current_month() {
        let expectedResult = Calendar.current.dateComponents([.day], from: Date()).day! <= 5
        
        XCTAssertEqual(Calendar.current.isOnTheFirstDaysFromCurrentMonth(days: 5), expectedResult)
    }
}
