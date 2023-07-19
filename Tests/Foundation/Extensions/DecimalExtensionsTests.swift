import Foundation
import MasMagicPills
import XCTest

class DecimalExtensionsTests: XCTestCase {
    func test_format_megabytes_in_spanish_format() {
        XCTAssertEqual((1_000 as Decimal).formattedMegabytes(.spanishSpain), "1 GB")
        XCTAssertEqual((900 as Decimal).formattedMegabytes(.spanishSpain), "900 MB")
        XCTAssertEqual((1_017 as Decimal).formattedMegabytes(.spanishSpain, decimals: 2), "1,02 GB")
        XCTAssertEqual((1_000 as Decimal).formattedMegabytes(.spanishSpain, decimals: 2), "1,00 GB")
        XCTAssertEqual((0 as Decimal).formattedMegabytes(.spanishSpain), "0 MB")
        XCTAssertEqual((3_000 as Decimal).formattedMegabytes(.spanishSpain, decimals: 2), "3,00 GB")
        XCTAssertEqual((3_000 as Decimal).formattedMegabytes(.spanishSpain), "3 GB")
        XCTAssertEqual((-3_000 as Decimal).formattedMegabytes(.spanishSpain, decimals: 2), "-3,00 GB")
    }

    func test_format_mebibytes_in_spanish_format() {
        XCTAssertEqual((1_024 as Decimal).formattedMebibytes(.spanishSpain), "1 GiB")
        XCTAssertEqual((900 as Decimal).formattedMebibytes(.spanishSpain), "900 MiB")
        XCTAssertEqual((1_017 as Decimal).formattedMebibytes(.spanishSpain, decimals: 2), "0,99 GiB")
        XCTAssertEqual((1_024 as Decimal).formattedMebibytes(.spanishSpain, decimals: 2), "1,00 GiB")
        XCTAssertEqual((0 as Decimal).formattedMebibytes(.spanishSpain), "0 MiB")
        XCTAssertEqual((3_000 as Decimal).formattedMebibytes(.spanishSpain, decimals: 2), "2,93 GiB")
        XCTAssertEqual((3_000 as Decimal).formattedMebibytes(.spanishSpain), "3 GiB")
        XCTAssertEqual((-3_000 as Decimal).formattedMebibytes(.spanishSpain, decimals: 2), "-2,93 GiB")
    }

    func test_format_megabit_in_spanish_format() {
        XCTAssertEqual((1_017 as Decimal).formattedMegabits(.spanishSpain, decimals: 2), "1,02 Gb")
        XCTAssertEqual((1_024 as Decimal).formattedMegabits(.spanishSpain, decimals: 2), "1,02 Gb")
        XCTAssertEqual((900 as Decimal).formattedMegabits(.spanishSpain), "900 Mb")
        XCTAssertEqual((0 as Decimal).formattedMegabits(.spanishSpain), "0 Mb")
        XCTAssertEqual((3_000 as Decimal).formattedMegabits(.spanishSpain, decimals: 2), "3,00 Gb")
        XCTAssertEqual((-3_000 as Decimal).formattedMegabits(.spanishSpain, decimals: 2), "-3,00 Gb")
    }

    func test_format_with_roundingmodes() {
        // FLOOR:
        XCTAssertEqual((5.532 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .floor, unit: Unit(symbol: "🍎")), "5.53 🍎")
        XCTAssertEqual((5.535 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .floor, unit: Unit(symbol: "🍎")), "5.53 🍎")
        XCTAssertEqual((5.537 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .floor, unit: Unit(symbol: "🍎")), "5.53 🍎")

        // CEILING:
        XCTAssertEqual((5.532 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .ceiling, unit: Unit(symbol: "🍎")), "5.54 🍎")
        XCTAssertEqual((5.535 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .ceiling, unit: Unit(symbol: "🍎")), "5.54 🍎")
        XCTAssertEqual((5.537 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .ceiling, unit: Unit(symbol: "🍎")), "5.54 🍎")

        // HALF-UP:
        XCTAssertEqual((5.532 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfUp, unit: Unit(symbol: "🍎")), "5.53 🍎")
        XCTAssertEqual((5.535 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfUp, unit: Unit(symbol: "🍎")), "5.54 🍎")
        XCTAssertEqual((5.537 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfUp, unit: Unit(symbol: "🍎")), "5.54 🍎")

        // HALF-DOWN:
        XCTAssertEqual((5.532 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfDown, unit: Unit(symbol: "🍎")), "5.53 🍎")
        XCTAssertEqual((5.535 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfDown, unit: Unit(symbol: "🍎")), "5.53 🍎")
        XCTAssertEqual((5.537 as Decimal).formatted(decimals: 2, locale: .englishUSA, roundingMode: .halfDown, unit: Unit(symbol: "🍎")), "5.54 🍎")
    }

    func test_format_number_without_unit() {
        XCTAssertEqual((33.24 as Decimal).formatted(decimals: 2,
                                                    locale: .spanishSpain), "33,24")

        XCTAssertEqual((1_345 as Decimal).formatted(decimals: 1,
                                                    locale: .englishUSA), "1345.0")
    }

    func test_format_currency() {
        XCTAssertEqual((33 as Decimal).formatted(decimals: 2,
                                                 locale: .spanishSpain,
                                                 unit: Unit(symbol: "$")), "33,00 $")

        XCTAssertEqual((1_345 as Decimal).formatted(decimals: 1,
                                                    locale: .spanishSpain,
                                                    unit: Unit(symbol: "€")), "1345,0 €")

        XCTAssertEqual((33 as Decimal).formatted(decimals: 2,
                                                 currencyCode: .euro,
                                                 locale: .spanishSpain), "33,00 €")

        XCTAssertEqual((345 as Decimal).formatted(decimals: 4,
                                                  currencyCode: .custom("AWA"),
                                                  locale: .spanishSpain), "345,0000 AWA")
    }

    func test_format_numberstyle() {
        XCTAssertEqual((1_000 as Decimal).formatted(decimals: 2,
                                                    locale: .spanishSpain,
                                                    numberStyle: .scientific), "1,00E3")

        XCTAssertEqual((16_868 as Decimal).formatted(locale: .spanishSpain,
                                                     numberStyle: .ordinal), "16.868.º")
    }

    func test_convert_miliseconds_to_seconds() {
        XCTAssertEqual((10_000 as Decimal).millisecondsToSeconds, 10)
    }

    func test_convert_miliseconds_to_minutes() {
        let number: Decimal = 124_232
        XCTAssertEqual(number.millisecondsToMinutes, number.millisecondsToSeconds.secondsToMinutes)
    }

    func test_convert_seconds_to_minutes() {
        XCTAssertEqual((6_000 as Decimal).secondsToMinutes, 100)
    }

    func test_split_for_positive_number() {
        let number: Decimal = 288.6970

        let result = number.split(decimals: 3)

        XCTAssertEqual(result.integerPart, 288)
        XCTAssertEqual(result.decimalPart, 697)
    }

    func test_split_for_negative_number() {
        let number: Decimal = -288.6970

        let result = number.split(decimals: 3)

        XCTAssertEqual(result.integerPart, -288)
        XCTAssertEqual(result.decimalPart, 697)
    }

    func test_format_decimal_part() {
        XCTAssertEqual((5.532 as Decimal).formattedDecimalPart(decimals: 1, locale: .spanishSpain), ",5")
        XCTAssertEqual((-5.532 as Decimal).formattedDecimalPart(decimals: 2, locale: .spanishSpain), ",53")
        XCTAssertEqual((-5 as Decimal).formattedDecimalPart(decimals: 4, locale: .spanishSpain), ",0000")
    }
}
