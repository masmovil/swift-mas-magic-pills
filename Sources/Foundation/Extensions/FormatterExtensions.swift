import Foundation

public extension Formatter {
    /// Get DateFormatter with specific Locale and TimeZone
    ///
    /// - Parameters:
    ///   - locale: Specific Locale to Format (optional) (by default use current)
    ///   - timeZone: Specific Time Zone to format (optional) (by default use current)
    /// - Returns: DateFormatter with specific or current Locale and Time Zone
    static func date(locale: Locale? = nil,
                     timeZone: TimeZone? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
        if let locale = locale { dateFormatter.locale = locale }
        if let timeZone = timeZone { dateFormatter.timeZone = timeZone }
        return dateFormatter
    }

    /// Get ISO8601 DateFormatter with specific Locale and TimeZone
    ///
    /// - Parameters:
    ///   - timeZone: Specific Time Zone to format (optional) (by default use current)
    /// - Returns: ISO8601DateFormatter with specific or current Time Zone
    static func iso8601Date(timeZone: TimeZone? = nil) -> ISO8601DateFormatter {
        let dateFormatter = ISO8601DateFormatter()
        if let timeZone = timeZone { dateFormatter.timeZone = timeZone }
        return dateFormatter
    }
}
