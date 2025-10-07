import Foundation

public extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: 1])
    }

    var formattedAsPhoneNumber: String {
        var formatted = self
        if formatted.count > 3 {
            formatted.insert(" ", at: index(startIndex, offsetBy: 3))
        }
        if formatted.count > 7 {
            formatted.insert(" ", at: index(startIndex, offsetBy: 7))
        }
        return formatted
    }

    /// Return numbers from string
    var onlyNumbers: String {
        self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }

    func removing(prefix: String) -> Self {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func removing(suffix: String) -> Self {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    var addingTrailingSpaceIfNotEmpty: Self {
        isEmpty ? "" : "\(self) "
    }

    var capitalizedWords: Self {
        self.split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var capitalizedSentences: Self {
        self.components(separatedBy: ". ")
            .map { String($0).capitalizedFirstLetter }
            .joined(separator: ". ")
    }

    var capitalizedFirstLetter: Self {
        if starts(withAnyOf: ["¡", "¿"]) {
            return prefix(2).uppercased() + dropFirst(2)
        }
        return prefix(1).uppercased() + dropFirst(1)
    }

    var lowercasedLeastTheFirstUnchanged: Self {
        prefix(1) + dropFirst().lowercased()
    }

    var removingWhiteSpaces: Self {
        components(separatedBy: .whitespaces).joined()
    }

    var trimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    var renderingUnicodeEmojis: Self {
        let regex = /(?i)(?:U\+|\\u\{?)([0-9A-F]{4,6})(?=\}$|\}(?:U\+|\\u)|(?:U\+|\\u)|[^0-9A-Za-z]|$)\}?/

        return self.replacing(regex) { match in
            let hexString = String(match.1)

            guard let unicodeValue = UInt32(hexString, radix: 16),
                  let scalar = UnicodeScalar(unicodeValue) else {
                return String(match.0)
            }

            return String(Character(scalar))
        }
    }
}
