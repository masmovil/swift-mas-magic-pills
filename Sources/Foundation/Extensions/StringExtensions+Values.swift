import Foundation

public extension String {
    var boolValue: Bool? {
        switch self.lowercased() {
        case "true", "yes", "1":
            return true

        case "false", "no", "0":
            return false

        default:
            return nil
        }
    }

    var urlValue: URL? {
        URL(string: self)
    }

    /// Return URL value only if an valid Url for Internet
    var internetUrlValue: URL? {
        if isValidInternetUrl {
            return urlValue
        }
        return nil
    }

    var dataUTF8: Data {
        data(using: String.Encoding.utf8)!
    }

    /// Convert String to Date with Date Format (if don't specify it, will look for all Date Formats contemplated)
    ///
    /// - Parameters:
    ///   - dateFormat: Format Date to convert
    ///   - locale: Language rules for date
    ///   - timeZone: Time zone to format date
    /// - Returns: Date with specified or resolved format
    func date(dateFormat: Date.Format? = nil,
              locale: Locale = .posix,
              timeZone: TimeZone = .utc) -> Date? {
        Date(formattedDate: self,
             dateFormat: dateFormat,
             locale: locale,
             timeZone: timeZone)
    }

    func htmlValue(fontSize: Float, fontFamily: String? = nil) -> String {
        if let fontFamily = fontFamily {
            return "<span style=\"font-family: \(fontFamily); font-size: \(fontSize)\">\(self)</span>"
        }
        return "<span style=\"font-size: \(fontSize)\">\(self)</span>"
    }
}
