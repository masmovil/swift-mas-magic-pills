import Foundation

extension Double {
    /// Return the given units of GB as bytes
    static func bytes(mebibytes: Double) -> Double {
        return 1_024 * 1_024 * 1_024 * mebibytes
    }

    /// Return the given units of MB as bytes
    static func bytes(gibibytes: Double) -> Double {
        return 1_024 * 1_024 * gibibytes
    }

    var toString: String {
        return "\(self)"
    }
}
