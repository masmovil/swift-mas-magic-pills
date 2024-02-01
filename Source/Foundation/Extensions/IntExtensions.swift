import Foundation

public extension Int {
    var stringValue: String {
        "\(self)"
    }

    var decimalValue: Decimal {
        Decimal(self)
    }

    @available(*, deprecated, renamed: "decimalValue")
    var toDecimal: Decimal {
        decimalValue
    }

    @available(*, deprecated, renamed: "stringValue")
    var toString: String {
        stringValue
    }
}
