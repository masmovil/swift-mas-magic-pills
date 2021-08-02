import Foundation

public extension TimeZone {
    static var utc: TimeZone { TimeZone(abbreviation: "UTC")! }
    static var europeMadrid: TimeZone { TimeZone(identifier: "Europe/Madrid")! }
}
