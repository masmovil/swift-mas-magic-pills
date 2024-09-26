import Foundation

public extension Locale {
    /// Resolved locale that correspond with POSIX standard
    static var posix: Locale { Locale(identifier: "en_US_POSIX") }

    /// Resolved locale that correspond with es_AR (🇦🇷)
    static var spanishArgentine: Locale { Locale(identifier: "es_AR") }

    /// Resolved locale that correspond with es_ES (🇪🇸)
    static var spanishSpain: Locale { Locale(identifier: "es_ES") }

    /// Resolved locale that correspond with ca_ES (🇪🇸)
    static var catalanSpain: Locale { Locale(identifier: "ca_ES") }

    /// Resolved locale that correspond with eu_ES (🇪🇸)
    static var basqueSpain: Locale { Locale(identifier: "eu_ES") }

    /// Resolved locale that correspond with en_US (🇺🇸)
    static var englishUSA: Locale { Locale(identifier: "en_US") }

    /// Resolved locale that correspond with en_GB (🇬🇧)
    static var englishUnitedKingdom: Locale { Locale(identifier: "en_GB") }

    /// Fixed locale without the region
    var fixed: Locale {
        if #available(iOSApplicationExtension 16, *), #available(macOSApplicationExtension 13, *), #available(tvOSApplicationExtension 16, *) {
            Locale(languageCode: language.languageCode,
                   script: nil,
                   languageRegion: nil)
        } else {
            Locale(identifier: languageCode!)
        }
    }
}
