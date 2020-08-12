import Foundation

extension Int64 {
    static func gigaBytes(_ amount: Int64) -> Int64 {
        return 1_024 * 1_024 * 1_024 * amount
    }

    static func megaBytes(_ amount: Int64) -> Int64 {
        return 1_024 * 1_024 * amount
    }

    var toString: String {
        return "\(self)"
    }
}
