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

    func removing(prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func removing(suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    var addingTrailingSpaceIfNotEmpty: String {
        isEmpty ? "" : "\(self) "
    }

    var capitalizedWords: String {
        self.split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var capitalizedSentences: String {
        self.components(separatedBy: ". ")
            .map { String($0).capitalizedFirstLetter }
            .joined(separator: ". ")
    }

    var capitalizedFirstLetter: String {
        if starts(withAnyOf: ["¡", "¿"]) {
            return prefix(2).uppercased() + dropFirst(2)
        }
        return prefix(1).uppercased() + dropFirst(1)
    }

    var lowercasedLeastTheFirstUnchanged: String {
        prefix(1) + dropFirst().lowercased()
    }

    var removingWhiteSpaces: String {
        components(separatedBy: .whitespaces).joined()
    }

    var trimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
