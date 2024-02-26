import Foundation

public extension Decimal {
    /// Return the given percent from current value (self)
    /// - Returns: Decimal
    func asPercentage(_ value: Decimal) -> Decimal {
        self / (100 / value)
    }

    /// Return the negated value
    var negated: Decimal {
        -self
    }

    /// Return true if value is != 0
    var isNotZero: Bool {
        !isZero
    }

    /// Return double from decimal value.
    var doubleValue: Double {
        Double(truncating: self as NSNumber)
    }

    @available(*, deprecated, renamed: "doubleValue")
    var asDouble: Double {
        doubleValue
    }

    /// Convert milliseconds(self) to seconds
    var millisecondsToSeconds: Decimal {
        self / 1_000
    }

    /// Convert milliseconds(self) to minutes
    var millisecondsToMinutes: Decimal {
        self / 60_000
    }

    /// Convert seconds(self) to minutes
    var secondsToMinutes: Decimal {
        self / 60
    }

    /// Return integer part
    var integerPart: Int {
        var result = Decimal()
        var mutableSelf = self
        NSDecimalRound(&result, &mutableSelf, 0, self >= 0 ? .down : .up)
        return Int(truncating: NSDecimalNumber(decimal: result))
    }

    /// Return decimal part
    func decimalPart(decimals: Int) -> Int {
        var result = Decimal()
        let powered = pow(Decimal(10), decimals)
        let integerPartToRemove = (powered * Decimal(abs(integerPart)))
        var elevated = powered * abs(self)

        NSDecimalRound(&result, &elevated, 0, .down)
        return Int(truncating: NSDecimalNumber(decimal: result - integerPartToRemove))
    }

    /// Split the number into decimal and integer part
    func split(decimals: Int) -> (integerPart: Int, decimalPart: Int) {
        (integerPart: integerPart,
         decimalPart: decimalPart(decimals: decimals))
    }

    /// Formats the decimal part from separator (without zero)
    func formattedDecimalPart(decimals: Int, locale: Locale = .current.fixed) -> String {
        let number = decimalPart(decimals: decimals)
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = decimals
        numberFormatter.maximumIntegerDigits = decimals

        return "\(locale.decimalSeparator ?? ".")\(numberFormatter.string(for: number) ?? "\(number)")"
    }

    /// Convert given megas to Megabytes (1000 bytes) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMegabytes(_ locale: Locale = .current.fixed,
                            decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_000).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "GB"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "MB"))
    }

    /// Convert given megas to Mebibytes (1024 bytes) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMebibytes(_ locale: Locale = .current.fixed,
                            decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_024).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "GiB"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "MiB"))
    }

    /// Convert to Megabits (1000 bits) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMegabits(_ locale: Locale = .current.fixed,
                           decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_000).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "Gb"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "Mb"))
    }

    /// Convert to string with specified parameters
    ///
    /// - Parameters:
    ///   - decimals: Number of decimals to use
    ///   - currencyCode: Three-letter code that denote the currency unit. For example, Australian dollar is “AUD”. Currency codes are based on the ISO 4217 standard.
    ///   - locale: Language rules to use
    ///   - numberStyle: Predefined number format style
    ///   - unit: Unit for Measurement format
    /// - Returns: String with specified format
    func formatted(decimals: Int = 2,
                   currencyCode: CurrencyCodeType? = nil,
                   locale: Locale = .current.fixed,
                   numberStyle: NumberFormatter.Style? = nil,
                   roundingMode: NumberFormatter.RoundingMode? = nil,
                   unit: Unit = Unit(symbol: "")) -> String {
        let numberFormatter = NumberFormatter()

        if let currencyCode = currencyCode?.rawValue {
            numberFormatter.currencyCode = currencyCode
            numberFormatter.numberStyle = .currency
        }

        if let numberStyle = numberStyle {
            numberFormatter.numberStyle = numberStyle
        }

        if let roundingMode = roundingMode {
            numberFormatter.roundingMode = roundingMode
        }

        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = decimals
        numberFormatter.maximumFractionDigits = decimals

        let formatter = MeasurementFormatter()
        formatter.locale = locale
        numberFormatter.locale = locale

        formatter.numberFormatter = numberFormatter

        let measurement = Measurement(value: Double(truncating: self as NSNumber), unit: unit)
        return formatter.string(from: measurement).trimmed
    }
}
