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

    func test_only_numbers() {
        XCTAssertEqual("asfw15as15352gd".onlyNumbers, "1515352")
    }

    func test_removing_suffix() {
        XCTAssertEqual("cuna".removing(suffix: "cu"), "cuna")
        XCTAssertEqual("cuna".removing(suffix: "na"), "cu")
    }

    func test_removing_prefix() {
        XCTAssertEqual("cuna".removing(prefix: "cu"), "na")
        XCTAssertEqual("cuna".removing(prefix: "sa"), "cuna")
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

    func test_rendering_valid_unicode_emojis() {
        XCTAssertEqual("Instalación rápida U+26A1".renderingUnicodeEmojis, "Instalación rápida ⚡")
        XCTAssertEqual("U+1F525 Ofertas especiales".renderingUnicodeEmojis, "🔥 Ofertas especiales")
        XCTAssertEqual("Instalación U+26A1 rápida".renderingUnicodeEmojis, "Instalación ⚡ rápida")
        XCTAssertEqual("U+1F44D Servicio U+26A1 rápido U+1F4B0".renderingUnicodeEmojis, "👍 Servicio ⚡ rápido 💰")
        XCTAssertEqual("Super oferta U+1F525U+1F4A5 disponible".renderingUnicodeEmojis, "Super oferta 🔥💥 disponible")
        XCTAssertEqual("U+1F525U+26A1U+1F44D".renderingUnicodeEmojis, "🔥⚡👍")
        XCTAssertEqual("Texto u+1f525 y U+26A1 mezclados".renderingUnicodeEmojis, "Texto 🔥 y ⚡ mezclados")
        XCTAssertEqual("Reloj U+23F0 temporizador".renderingUnicodeEmojis, "Reloj ⏰ temporizador")
        XCTAssertEqual("Fire U+1F525 emoji".renderingUnicodeEmojis, "Fire 🔥 emoji")
        XCTAssertEqual("Test U+1F1E8U+1F1F4 flag".renderingUnicodeEmojis, "Test 🇨🇴 flag")
    }

    func test_rendering_normal_text_as_unicode_emojis() {
        XCTAssertEqual("Texto normal sin códigos unicode".renderingUnicodeEmojis, "Texto normal sin códigos unicode")
        XCTAssertEqual("    ".renderingUnicodeEmojis, "    ")
        XCTAssertEqual("".renderingUnicodeEmojis, "")
    }

    func test_rendering_invalid_unicode_emojis() {
        XCTAssertEqual("U+ U+12 U+GGG U+12345G texto".renderingUnicodeEmojis, "U+ U+12 U+GGG U+12345G texto")
        XCTAssertEqual("u+ u+12 u+GGG u+12345g texto".renderingUnicodeEmojis, "u+ u+12 u+GGG u+12345g texto")
        XCTAssertEqual("U+ U+12 U+GGG U+12345x texto".renderingUnicodeEmojis, "U+ U+12 U+GGG U+12345x texto")
        XCTAssertEqual("Valid U+1F525 invalid U+12 valid U+26A1".renderingUnicodeEmojis, "Valid 🔥 invalid U+12 valid ⚡")
        XCTAssertEqual("Texto normal sin códigos unicode".renderingUnicodeEmojis, "Texto normal sin códigos unicode")
    }
}
