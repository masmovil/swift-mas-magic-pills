import Foundation

public extension Int {
    var stringValue: String {
        "\(self)"
    }

    @available(*, deprecated, renamed: "stringValue")
    var toString: String {
        "\(self)"
    }
}
