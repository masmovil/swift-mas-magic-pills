import Foundation

extension Double {
    /// Return the given units of GB as bytes
    static func bytes(mebibytes: Double) -> Double {
        1_024 * 1_024 * 1_024 * mebibytes
    }

    /// Return the given units of MB as bytes
    static func bytes(gibibytes: Double) -> Double {
        1_024 * 1_024 * gibibytes
    }

    var stringValue: String {
        "\(self)"
    }

    @available(*, deprecated, renamed: "stringValue")
    var toString: String {
        "\(self)"
    }
}
