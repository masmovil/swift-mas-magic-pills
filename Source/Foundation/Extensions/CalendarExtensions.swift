import Foundation

public extension Calendar {
    
    // Calendar for Madrid (Spain)
    static var spainMadrid: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = .init(identifier: "Europe/Madrid")!
        return calendar
    }
    
    /// Check if it's in first days of current month
    ///
    /// - Parameters:
    ///   - days: Number of days since 1st of current month
    func isOnTheFirstDaysFromCurrentMonth(days: Int) -> Bool {
        return isInRangeFromCurrentMonth(days: 1...days)
    }
    
    /// Check if it's in the range of days of current month
    ///
    /// - Parameters:
    ///   - days: Range of days to check in current month
    func isInRangeFromCurrentMonth(days: ClosedRange<Int>) -> Bool {
        let currentDay = component(.day, from: Date())
        return days ~= currentDay
    }
    
    /// Check if all dates given are the same day
    ///
    /// - Parameters:
    ///   - dates: Dates to check
    func allDatesAreOnSameDay(dates: Date...) -> Bool {
        return dates.allSatisfy {
            self.isDate(dates.first!, inSameDayAs: $0)
        }
    }
}
