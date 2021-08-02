import Foundation

public extension Locale {
    /// Resolved locale that correspond with POSIX standard
    static var posix: Locale { Locale(identifier: "en_US_POSIX") }

    /// Resolved locale that correspond with es_ES
    static var spanishSpain: Locale { Locale(identifier: "es_ES") }

    /// Resolved locale that correspond with es_ES
    static var catalanSpain: Locale { Locale(identifier: "ca_ES") }

    /// Resolved locale that correspond with es_ES
    static var basqueSpain: Locale { Locale(identifier: "eu_ES") }

    /// Resolved locale that correspond with en_US
    static var englishUSA: Locale { Locale(identifier: "en_US") }
}
