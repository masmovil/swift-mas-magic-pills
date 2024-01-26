import Foundation
import MasMagicPills
import XCTest

class StringExtensionsFormatingTests: XCTestCase {
    func test_underlined() {
        let string = "hola"
        let attr = string.underLined

        let bodyAttributesLower = attr.attributes(at: 0, effectiveRange: nil)
        let bodyAttributesUpper = attr.attributes(at: string.count - 1, effectiveRange: nil)

        XCTAssertEqual(bodyAttributesLower[.underlineStyle] as? Int, 1)
        XCTAssertEqual(bodyAttributesUpper[.underlineStyle] as? Int, 1)
    }

    func test_format_phone() {
        XCTAssertEqual("123".formattedAsPhoneNumber, "123")
        XCTAssertEqual("1231".formattedAsPhoneNumber, "123 1")
        XCTAssertEqual("12312".formattedAsPhoneNumber, "123 12")
        XCTAssertEqual("123123".formattedAsPhoneNumber, "123 123")
        XCTAssertEqual("1231234".formattedAsPhoneNumber, "123 123 4")
        XCTAssertEqual("12312345".formattedAsPhoneNumber, "123 123 45")
        XCTAssertEqual("123123123".formattedAsPhoneNumber, "123 123 123")
        XCTAssertEqual("".formattedAsPhoneNumber, "")
    }

    func test_addtrailingspaceifnotempty() {
        XCTAssertEqual("".addingTrailingSpaceIfNotEmpty, "")
        XCTAssertEqual("hola".addingTrailingSpaceIfNotEmpty, "hola ")
    }

    func test_capitalizedWords() {
        XCTAssertEqual("hola que tal?".capitalizedWords, "Hola Que Tal?")
        XCTAssertEqual("hola y chau".capitalizedWords, "Hola Y Chau")
    }

    func test_capitalizedSentences() {
        XCTAssertEqual("hola. soy un test".capitalizedSentences, "Hola. Soy un test")
        XCTAssertEqual("wawa. wewe we wi. wowo".capitalizedSentences, "Wawa. Wewe we wi. Wowo")
    }

    func test_capitalized_first_letter() {
        XCTAssertEqual("".capitalizedFirstLetter, "")
        XCTAssertEqual("Hola".capitalizedFirstLetter, "Hola")
        XCTAssertEqual("HOLA".capitalizedFirstLetter, "HOLA")
        XCTAssertEqual("hOLA".capitalizedFirstLetter, "HOLA")
        XCTAssertEqual("¿hola?".capitalizedFirstLetter, "¿Hola?")
        XCTAssertEqual("¡chau!".capitalizedFirstLetter, "¡Chau!")
    }

    func test_lowercased_all_least_the_first_unchanged() {
        XCTAssertEqual("Hola".lowercasedLeastTheFirstUnchanged, "Hola")
        XCTAssertEqual("HOLA".lowercasedLeastTheFirstUnchanged, "Hola")
        XCTAssertEqual("hOLA".lowercasedLeastTheFirstUnchanged, "hola")
    }

    func test_removing_whitespaces() {
        XCTAssertEqual("hola que tal".removingWhiteSpaces, "holaquetal")
    }

    func test_trimed() {
        XCTAssertEqual(" hola ".trimmed, "hola")
    }
}
