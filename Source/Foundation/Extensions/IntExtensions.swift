import Foundation

public extension Int {
    @available(*, deprecated, renamed: "toString")
    var string: String {
        toString
    }

    var toString: String {
        "\(self)"
    }
}
