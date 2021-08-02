import Foundation

public extension Int64 {
    /// Return the given Gigabits as bits
    /// - Parameter gigabits: Gigabits to convert
    /// - Returns: Bits conversion result
    static func bits(gigabits: Int64) -> Int64 {
        1_000 * 1_000 * 1_000 * gigabits
    }

    /// Return the given Megabits as bits
    /// - Parameter megabits: Megabits to convert
    /// - Returns: Bits conversion result
    static func bits(megabits: Int64) -> Int64 {
        1_000 * 1_000 * megabits
    }

    /// Return the given Mebibytes as bits
    /// - Parameter mebibytes: Mebibytes to convert
    /// - Returns: Bits conversion result
    static func bits(mebibytes: Int64) -> Int64 {
        1_000 * 1_000 * 8 * mebibytes
    }

    /// Return the given Kilobits as bits
    /// - Parameter kilobits: Kilobits to convert
    /// - Returns: Bits conversion result
    static func bits(kilobits: Int64) -> Int64 {
        1_000 * kilobits
    }

    // MARK: - Bytes

    /// Return the given Gibibytes as bits
    /// - Parameter gibibytes: Gibibytes to convert
    /// - Returns: Bytes conversion result
    static func bytes(gibibytes: Int64) -> Int64 {
        1_024 * 1_024 * 1_024 * gibibytes
    }

    /// Return the given Mebibytes as bytes
    /// - Parameter mebibytes: Mebibytes to convert
    /// - Returns: Bytes conversion result
    static func bytes(mebibytes: Int64) -> Int64 {
        1_024 * 1_024 * mebibytes
    }

    /// Return the given Megabits as bytes
    /// - Parameter megabits: Megabits to convert
    /// - Returns: Bytes conversion result
    static func bytes(megabits: Int64) -> Int64 {
        1_000 * 1_000 * megabits / 8
    }

    /// Return the given Kibibytes as bytes
    /// - Parameter kibibytes: Kibibytes to convert
    /// - Returns: Bytes conversion result
    static func bytes(kibibytes: Int64) -> Int64 {
        1_000 * kibibytes
    }

    /// Return the given units of GiB as bytes
    @available(*, deprecated, renamed: "bytes(gibibytes:)")
    static func gigaBytes(_ amount: Int64) -> Int64 {
        bytes(gibibytes: amount)
    }

    /// Return the given units of MiB as bytes
    @available(*, deprecated, renamed: "bytes(mebibytes:)")
    static func megaBytes(_ amount: Int64) -> Int64 {
        bytes(mebibytes: amount)
    }

    var toString: String {
        "\(self)"
    }
}
