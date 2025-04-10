import Foundation
import MasMagicPills
import XCTest

class DateExtensionsTests: XCTestCase {
    func test_adding() {
        let date = Date(formattedDate: "2019-08-13T10:48:00Z", timeZone: .utc)!

        XCTAssertEqual(date.adding(years: 1).formatted(with: .iso8601, timeZone: .utc), "2020-08-13T10:48:00Z")
        XCTAssertEqual(date.adding(days: 10).formatted(with: .iso8601, timeZone: .utc), "2019-08-23T10:48:00Z")
        XCTAssertEqual(date.adding(months: 2).formatted(with: .iso8601, timeZone: .utc), "2019-10-13T10:48:00Z")
        XCTAssertEqual(date.adding(hours: 10).formatted(with: .iso8601, timeZone: .utc), "2019-08-13T20:48:00Z")
        XCTAssertEqual(date.adding(minutes: 10).formatted(with: .iso8601, timeZone: .utc), "2019-08-13T10:58:00Z")
    }

    func test_previousMonthName() {
        let expectedMonthName = Date().adding(months: -1).formatted(with: .month, locale: .spanishSpain)
        XCTAssertEqual(Date.previousMonthName(locale: .spanishSpain), expectedMonthName)
    }

    func test_init_from_formatted_dates() {
        let rfcDate = Date(formattedDate: "2019-08-09T12:48:00.000+0200",
                           dateFormat: .iso8601)
        XCTAssertEqual(rfcDate?.formatted(with: .iso8601, timeZone: .utc), "2019-08-09T10:48:00Z")

        let iso8601DateUTC = Date(formattedDate: "2020-02-10T17:26:08Z",
                                  dateFormat: .iso8601)
        XCTAssertEqual(iso8601DateUTC?.formatted(with: .iso8601, timeZone: .utc), "2020-02-10T17:26:08Z")

        let iso8601DateZoned = Date(formattedDate: "2020-02-10T17:26:08+0200",
                                    dateFormat: .iso8601)
        XCTAssertEqual(iso8601DateZoned?.formatted(with: .iso8601, timeZone: .utc), "2020-02-10T15:26:08Z")

        let iso8601DateWithoutSeconds = Date(formattedDate: "2020-02-03T19:39Z",
                                             dateFormat: .iso8601)
        XCTAssertEqual(iso8601DateWithoutSeconds?.formatted(with: .iso8601, timeZone: .utc), "2020-02-03T19:39:00Z")

        let invalidDate = Date(formattedDate: "⚠️")
        XCTAssertNil(invalidDate)

        let spanishDate = Date(formattedDate: "20/02/2018 12:33",
                               timeZone: .europeMadrid)
        XCTAssertEqual(spanishDate?.formatted(with: .iso8601, timeZone: .utc), "2018-02-20T11:33:00Z")
    }

    func test_init_with_milliseconds() {
        let milliseconds: Double = 12_408_124_000
        let date = Date(millisecondsSince1970: milliseconds)

        XCTAssertEqual(date.millisecondsSince1970, milliseconds)
    }

    func test_init_with_rfc1123date() {
        let rfc1123Date = "Fri, 16 Apr 2021 14:37:26 GMT"
        let date = rfc1123Date.date(dateFormat: .rfc1123, locale: .posix, timeZone: .utc)

        XCTAssertEqual(date?.formatted(with: .rfc1123,
                                       locale: .posix,
                                       timeZone: .utc),
                       rfc1123Date)
    }

    func test_init_with_rfc1123date_with_offset() {
        let rfc1123Date = "Fri, 09 Aug 2019 12:48:00 +0200"
        let date = rfc1123Date.date(dateFormat: .rfc1123, locale: .posix, timeZone: .utc)

        XCTAssertEqual(date?.formatted(with: .rfc1123,
                                       locale: .posix,
                                       timeZone: .utc),
                       "Fri, 09 Aug 2019 10:48:00 GMT")
    }

    func test_init_with_iso8601date_with_seconds_and_thousandths() {
        let iso8601Date = "2019-08-09T10:48:00.000+0200"
        let date = iso8601Date.date()
        XCTAssertEqual(date?.formatted(with: .iso8601,
                                       timeZone: .europeMadrid),
                       "2019-08-09T10:48:00+0200")
        XCTAssertNil("👋".date())
    }

    func test_init_with_iso8601date_with_seconds() {
        let iso8601Date = "2022-10-27T16:00:00+0200"
        let date = iso8601Date.date(dateFormat: .iso8601)
        XCTAssertEqual(date?.formatted(with: .iso8601,
                                       timeZone: .europeMadrid),
                       "2022-10-27T16:00:00+0200")
        XCTAssertNil("👋".date())
    }

    func test_init_with_iso8601date_with_no_seconds() { // "2021-04-07T09:00+01:00"
        let iso8601Date = "2021-04-07T09:00+0100"
        let date = iso8601Date.date()
        XCTAssertEqual(date?.formatted(with: .iso8601,
                                       timeZone: .europeMadrid),
                       "2021-04-07T10:00:00+0200")
        XCTAssertNil("👋".date())
    }

    func test_init_with_formatted_spanishDate() {
        let spanishFullDate = "20/02/2018 12:33"
        var date = Date(formattedDate: spanishFullDate,
                        timeZone: .europeMadrid)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .europeMadrid),
                       spanishFullDate)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .utc),
                       "20/02/2018 11:33")

        let summerSpanishFullDate = "20/08/2018 12:33"
        date = Date(formattedDate: summerSpanishFullDate,
                    timeZone: .europeMadrid)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .europeMadrid),
                       summerSpanishFullDate)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .utc),
                       "20/08/2018 10:33")
    }

    func test_date_formats() {
        let date = Date(formattedDate: "09/08/2019 10:48", timeZone: .utc)!

        XCTAssertEqual(date.formatted(with: .iso8601, timeZone: .utc), "2019-08-09T10:48:00Z")
        XCTAssertEqual(date.formatted(with: .iso8601, timeZone: .europeMadrid), "2019-08-09T12:48:00+0200")
        XCTAssertEqual(date.formatted(with: .rfc1123, locale: .englishUSA, timeZone: .europeMadrid), "Fri, 09 Aug 2019 12:48:00 GMT+2")
        XCTAssertEqual(date.formatted(with: .spanishDateWithSlashes, timeZone: .europeMadrid), "09/08/2019")
        XCTAssertEqual(date.formatted(with: .americanDateWithSlashes, timeZone: .europeMadrid), "08/09/2019")
        XCTAssertEqual(date.formatted(with: .spanishDayAndMonthWithSlashes), "09/08")
        XCTAssertEqual(date.formatted(with: .spanishMonthAndYearWithSlashes), "08/19")
        XCTAssertEqual(date.formatted(with: .spanishFullDateWithSlashes, timeZone: .europeMadrid), "09/08/2019 12:48")
        XCTAssertEqual(date.formatted(with: .americanFullDateWithSlashes, timeZone: .europeMadrid), "08/09/2019 12:48")
        XCTAssertEqual(date.formatted(with: .europeanFullDateWithSlashes, timeZone: .europeMadrid), "2019/08/09 12:48")
        XCTAssertEqual(date.formatted(with: .europeanDateWithDashes, timeZone: .europeMadrid), "2019-08-09")
        XCTAssertEqual(date.formatted(with: .time, timeZone: .europeMadrid), "12:48")
        XCTAssertEqual(date.formatted(with: .day), "9")
        XCTAssertEqual(date.formatted(with: .dayAndMonth, locale: .spanishSpain), "9 ago")
        XCTAssertEqual(date.formatted(with: .shortMonth, locale: .spanishSpain), "ago")
        XCTAssertEqual(date.formatted(with: .month, locale: .spanishSpain), "agosto")
        XCTAssertEqual(date.formatted(with: .monthAndYear, locale: .spanishSpain), "agosto 2019")
        XCTAssertEqual(date.formatted(with: .monthAndYearWithUnderscore, locale: .spanishSpain), "agosto_2019")
        XCTAssertEqual(date.formatted(with: .shortYear), "19")
        XCTAssertEqual(date.formatted(with: .year), "2019")
        XCTAssertEqual(date.formatted(with: .yearAndMonth), "2019-08")
        XCTAssertEqual(date.formatted(with: .spanishDayAndMonth, locale: .spanishSpain, timeZone: .europeMadrid), "09 de agosto")
        XCTAssertEqual(date.formatted(with: .americanDayAndMonth, locale: .englishUSA, timeZone: .europeMadrid), "August 09")
        XCTAssertEqual(date.formatted(with: .spanishMonthAndYear, locale: .spanishSpain, timeZone: .europeMadrid), "agosto de 2019")
    }

    func test_is_today() {
        XCTAssertTrue(Date().isToday)
        XCTAssertFalse(Date().addingTimeInterval(-86_400).isToday)
    }

    func test_is_in_the_first_eleven_days_of_the_month() {
        stride(from: 1, to: 31, by: 1).forEach { day in
            let date = "\(day)/01/2018 11:11".date()

            XCTAssertEqual(date?.isInTheFirstElevenDaysOfTheMonth, day <= 11, "\(String(describing: date)) dont pass validation")
        }
    }

    func test_is_in_the_first_three_days_of_the_month() {
        stride(from: 1, to: 31, by: 1).forEach { day in
            let date = "\(day)/01/2018 11:11".date()

            XCTAssertEqual(date?.isInTheFirstThreeDaysOfTheMonth, day <= 3, "\(String(describing: date)) dont pass validation")
        }
    }

    func test_months_between_dates() {
        var date1 = Date(formattedDate: "20/02/2018 12:33", timeZone: .europeMadrid)!
        var date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .europeMadrid)!
        XCTAssertEqual(date1.months(to: date2), 3)

        date1 = Date(formattedDate: "19/02/2018 12:33", timeZone: .europeMadrid)!
        date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .europeMadrid)!
        XCTAssertEqual(date1.months(to: date2), 4)

        date1 = Date(formattedDate: "25/02/2018 12:33", timeZone: .europeMadrid)!
        date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .europeMadrid)!
        XCTAssertEqual(date1.months(to: date2, ignoringDays: true), 4)
    }

    func test_morning_day_moment() {
        let morningMoment = Date(formattedDate: "20/02/2018 8:00", timeZone: .europeMadrid)!.dayMoment
        XCTAssertEqual(morningMoment, DayMomentType.morning)
    }

    func test_afternoon_day_moment() {
        let afternoonMoment = Date(formattedDate: "20/02/2018 16:00", timeZone: .europeMadrid)!.dayMoment
        XCTAssertEqual(afternoonMoment, DayMomentType.afternoon)
    }

    func test_night_day_moment() {
        let nightMoment = Date(formattedDate: "20/02/2018 22:00", timeZone: .europeMadrid)!.dayMoment
        XCTAssertEqual(nightMoment, DayMomentType.night)
    }

    func test_parsing_date_with_carriage_return() {
        XCTAssertNotNil(Date(formattedDate: " 2022-09-13T17:22:11Z \r\n", dateFormat: .iso8601))
    }
}
