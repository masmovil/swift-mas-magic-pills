import Foundation

public extension Int {
    @available(*, deprecated, renamed: "toString")
    var string: String {
        return toString
    }

    var toString: String {
        return "\(self)"
    }
}
