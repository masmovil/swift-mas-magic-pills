import Foundation

public extension Date {
    /// Init Date with String and Date Format (if you don't specify it, will look for all Date Formats contemplated)
    ///
    /// - Parameters:
    ///   - formattedDate: String with date
    ///   - dateFormat: Format Date to convert (optional)
    ///   - locale: Language rules for date (optional) (by default use current)
    ///   - timeZone: Time zone to format date (optional) (by default use current)
    init?(formattedDate: String,
          dateFormat: Format? = nil,
          locale: Locale? = nil,
          timeZone: TimeZone? = nil) {
        if let dateFormat = dateFormat, let date = dateFormat.date(from: formattedDate, locale: locale, timeZone: timeZone) {
            self = date
            return
        }

        for dateFormat in Format.allCases {
            if let date = dateFormat.date(from: formattedDate, locale: locale, timeZone: timeZone) {
                self = date
                return
            }
        }
        return nil
    }

    /// Init Date with strategy that decodes dates in terms of milliseconds since midnight UTC on January 1st, 1970
    ///
    /// - Parameter millisecondsSince1970: milliseconds that corresponds with the date to parse
    init(millisecondsSince1970: Double) {
        self = Date(timeIntervalSince1970: millisecondsSince1970 / 1_000)
    }

    /// Return a new date by adding the given years
    func adding(years: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(year: years), to: self) else {
            fatalError("Cannot add \(years) years to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given days
    func adding(days: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(day: days), to: self) else {
            fatalError("Cannot add \(days) days to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given months
    func adding(months: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(month: months), to: self) else {
            fatalError("Cannot add \(months) months to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given hours
    func adding(hours: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(hour: hours), to: self) else {
            fatalError("Cannot add \(hours) hours to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given minutes
    func adding(minutes: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(minute: minutes), to: self) else {
            fatalError("Cannot add \(minutes) minutes to date \(self)")
        }
        return newDate
    }

    /// Milliseconds since midnight UTC on January 1st, 1970 that corresponds with Date
    var millisecondsSince1970: Double {
        timeIntervalSince1970 * 1_000.0
    }

    /// Check if day in date is between day 1 and 11 of the month (included)
    var isInTheFirstElevenDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...11 ~= day
    }

    /// Check if day in date is between day 1 and 3 of the month (included)
    var isInTheFirstThreeDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...3 ~= day
    }

    /// Check if day in date corresponds with current day
    var isToday: Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.isDateInToday(self)
    }

    /// Format Date in an string with specified format
    ///
    /// - Parameters:
    ///   - dateFormat: Date Format to convert
    ///   - locale: Language rules (optional) (by default use current)
    ///   - timeZone: Time zone to format date (optional) (by default use current)
    /// - Returns: Date formatted
    func formatted(with dateFormat: Date.Format,
                   locale: Locale? = nil,
                   timeZone: TimeZone? = nil) -> String {
        dateFormat.string(from: self, locale: locale, timeZone: timeZone)
    }

    /// Calculate months to end dates, included days in last month or not
    ///
    /// - Parameters:
    ///   - endDate: date to
    ///   - ignoringDays: boolean that indicate if calculate with days (By default included it)
    /// - Returns: Amount of months between this dates (optional)
    func months(to endDate: Date, ignoringDays: Bool = false) -> Int {
        var startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        var endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        startDateComponents.day = ignoringDays ? 1 : startDateComponents.day
        endDateComponents.day = ignoringDays ? 1 : endDateComponents.day

        return Calendar
            .current
            .dateComponents([.month],
                            from: startDateComponents,
                            to: endDateComponents).month!
    }

    /// Calculate moment of day
    var dayMoment: DayMomentType {
        let dateComponents = Calendar.current.dateComponents([.hour], from: self)

        if let hour = dateComponents.hour {
            switch hour {
            case 7..<15:
                return .morning

            case 15..<21:
                return .afternoon

            default:
                return .night
            }
        }
        return .morning
    }
}
