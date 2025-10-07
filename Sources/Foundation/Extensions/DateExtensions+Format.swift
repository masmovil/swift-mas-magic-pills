import Foundation

public extension Date {
    /// Specify date format to convert
    ///
    /// - iso8601: 2019-08-09T12:48:00.000+0200
    /// - rfc1123: Fri, 09 Aug 2019 12:48:00 GMT+2
    /// - spanishFullDateWithSlashes: 09/08/2019 12:48
    /// - americanFullDateWithSlashes: 08/09/2019 12:48
    /// - europeanFullDateWithSlashes: 2019/08/09 12:48
    /// - europeanDateWithDashes: 2019-08-09
    /// - time: 12:48
    /// - day: 9
    /// - dayAndMonth: 9 aug
    /// - shortMonth: aug
    /// - month: august
    /// - monthAndYear: august 2019
    /// - monthAndYearWithUnderscore: august_2019
    /// - shortYear: 19
    /// - year: 2019
    /// - spanishDayAndMonth: 09 de agosto
    enum Format: String, CaseIterable {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
        case rfc1123 = "EEE, dd MMM yyyy HH:mm:ss z"
        case spanishDateWithSlashes = "dd/MM/yyyy"
        case americanDateWithSlashes = "MM/dd/yyyy"
        case spanishDayAndMonthWithSlashes = "dd/MM"
        case spanishMonthAndYearWithSlashes = "MM/yy"
        case spanishFullDateWithSlashes = "dd/MM/yyyy HH:mm"
        case americanFullDateWithSlashes = "MM/dd/yyyy HH:mm"
        case europeanFullDateWithSlashes = "yyyy/MM/dd HH:mm"
        case europeanDateWithDashes = "yyyy-MM-dd"
        case time = "HH:mm"
        case day = "d"
        case dayAndShortMonth = "d MMM"
        case dayAndMonth = "d MMMM"
        case shortMonth = "MMM"
        case month = "MMMM"
        case monthAndYear = "MMMM yyyy"
        case monthAndYearWithUnderscore = "MMMM_yyyy"
        case shortYear = "yy"
        case year = "yyyy"
        case yearAndMonth = "yyyy-MM"
        case spanishDayAndMonth = "dd 'de' MMMM"
        case americanDayAndMonth = "MMMM dd"
        case spanishMonthAndYear = "MMMM 'de' yyyy"
        case dateStyleShort = "dateStyleShort"
        case dateStyleMedium = "dateStyleMedium"
        case dateStyleLong = "dateStyleLong"
        case dateStyleFull = "dateStyleFull"

        func string(from date: Date, locale: Locale?, timeZone: TimeZone?, useLocalizedTemplate: Bool = false) -> String {
            formatter(locale: locale, timeZone: timeZone, useLocalizedTemplate: useLocalizedTemplate)
                .string(from: date)
        }

        func date(from formattedDate: String, locale: Locale?, timeZone: TimeZone?) -> Date? {
            guard let dateFormats = dateFormats(timeZone: timeZone) else {
                return nil
            }

            let formatter = formatter(locale: locale, timeZone: timeZone)
            for dateFormat in dateFormats {
                formatter.dateFormat = dateFormat
                let date = formatter.date(from: formattedDate.trimmed)
                if date != nil { return date }
            }

            // If all dateFormats fail, try with ISO8601Formatter:
            if case .iso8601 = self {
                let iso8601Formatter = Formatter.iso8601Date(timeZone: timeZone)
                return iso8601Formatter.date(from: formattedDate.trimmed)
            }

            // Sorry! not recognized
            return nil
        }

        func dateFormats(timeZone: TimeZone?) -> [String]? {
            guard let mainDateFormat = mainDateFormat(timeZone: timeZone) else {
                return nil
            }

            switch self {
            case .iso8601:
                return [mainDateFormat,
                        "yyyy-MM-dd'T'HH:mmZ",
                        "yyyy-MM-dd'T'HH:mm'Z'",
                        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"]

            case .rfc1123:
                return [mainDateFormat,
                        "EEE, dd MMM yyyy HH:mm:ss Z"]

            default:
                return [mainDateFormat]
            }
        }

        func mainDateFormat(timeZone: TimeZone?) -> String? {
            switch self {
            // For ISO8601 dates, if the timezone is UTC, use Z instead of +0000
            case .iso8601 where timeZone == .utc:
                return rawValue.replacingOccurrences(of: "Z", with: "'Z'")

            case .dateStyleShort:
                return nil

            case .dateStyleMedium:
                return nil

            case .dateStyleLong:
                return nil

            case .dateStyleFull:
                return nil

            default:
                return rawValue
            }
        }

        func formatter(locale: Locale?, timeZone: TimeZone?, useLocalizedTemplate: Bool = false) -> DateFormatter {
            let dateFormatter = Formatter.date(locale: locale, timeZone: timeZone)
            let format = mainDateFormat(timeZone: timeZone)

            switch self {
            case .dateStyleShort:
                dateFormatter.dateStyle = .short

            case .dateStyleMedium:
                dateFormatter.dateStyle = .medium

            case .dateStyleLong:
                dateFormatter.dateStyle = .long

            case .dateStyleFull:
                dateFormatter.dateStyle = .full

            case .iso8601, .rfc1123:
                dateFormatter.dateFormat = format

            default:
                dateFormatter.dateFormat = format
                if useLocalizedTemplate, let format {
                    dateFormatter.setLocalizedDateFormatFromTemplate(format)
                }
            }
            return dateFormatter
        }
    }
}
