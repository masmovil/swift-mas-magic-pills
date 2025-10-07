import Foundation

public extension TimeInterval {
    /// Format the 'TimeInterval' in a human-readable string.
    ///
    /// - Output examples:
    ///     ```
    ///     TimeInterval(3_600_000).formatted //1h 0m 0s
    ///     TimeInterval(3_600_000).formatted //1m 2s
    ///     ```
    var formatted: String {
        switch self {
        case (-Double.greatestFiniteMagnitude)...(-3_600_000), 3_600_000...Double.greatestFiniteMagnitude:
            return String(format: "%dh %dm %ds", hours, abs(minutes), abs(seconds))

        case (-3_600_000)...(-60_000), 60_000...3_599_999:
            return String(format: "%dm %ds", minutes, abs(seconds))

        default:
            return String(format: "%ds", seconds)
        }
    }

    var hours: Int {
        Int((self / 3_600_000).truncatingRemainder(dividingBy: 24))
    }

    var minutes: Int {
        Int((self / 60_000).truncatingRemainder(dividingBy: 60))
    }

    var seconds: Int {
        Int((self / 1_000).truncatingRemainder(dividingBy: 60))
    }
}
