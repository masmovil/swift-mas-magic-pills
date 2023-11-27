import Foundation

public extension String {
    /// Return numbers from string
    var onlyNumbers: String {
        self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }

    /// Return URL value only if an valid Url for Internet
    var internetUrlValue: URL? {
        if isValidInternetUrl {
            return urlValue
        }
        return nil
    }

    /// Remove a prefix from a String
    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    var addTrailingSpaceIfNotEmpty: String {
        isEmpty ? "" : "\(self) "
    }

    var capitalizeWords: String {
        self.split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var capitalizeSentences: String {
        self.components(separatedBy: ". ")
            .map { String($0).capitalizedFirstLetter }
            .joined(separator: ". ")
    }

    func starts(withAnyOf: [String]) -> Bool {
        withAnyOf.contains { starts(with: $0) }
    }

    var capitalizedFirstLetter: String {
        if starts(withAnyOf: ["¡", "¿"]) {
            return prefix(2).uppercased() + dropFirst(2)
        }
        return prefix(1).uppercased() + dropFirst(1)
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

    var lowercasedLeastTheFirstUnchanged: String {
        prefix(1) + dropFirst().lowercased()
    }

    var dataUTF8: Data {
        data(using: String.Encoding.utf8)!
    }

    var removingWhiteSpaces: String {
        components(separatedBy: .whitespaces).joined()
    }

    var trimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Decode Base64 string if possible. Returns nil if fails.
    var base64decoded: String? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    /// Decode Base64 URL-Safe string if possible. Returns nil if fails.
    var base64UrlDecoded: String? {
        var base64 = self
            .replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")

        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        return base64.base64decoded
    }

    /// Encode into Base64 String
    var base64encoded: String {
        dataUTF8.base64EncodedString()
    }

    /// Encode into Base64 URL-Safe string.
    var base64UrlEncoded: String {
        base64encoded
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "=", with: "")
    }

    func localized(bundle: Bundle = .main, tableName: String = "Common") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }

    func htmlValue(fontSize: Float, fontFamily: String? = nil) -> String {
        if let fontFamily = fontFamily {
            return "<span style=\"font-family: \(fontFamily); font-size: \(fontSize)\">\(self)</span>"
        }
        return "<span style=\"font-size: \(fontSize)\">\(self)</span>"
    }

    func satisfiesRegex(_ regex: String) -> Bool {
        range(of: regex, options: .regularExpression) != nil
    }

    /// Replaces the matches of the given regex pattern with an user-defined String.
    func replacingRegexMatches(of pattern: String, with replacing: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacing)
    }

    /// Look for where is the first text occurence in string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Range for the first text occurence in string (optional)
    func firstRangeOcurrence(_ text: String,
                             options: String.CompareOptions = [],
                             range: Range<Index>? = nil,
                             locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: text,
                                     options: options,
                                     range: range ?? startIndex..<endIndex,
                                     locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }

    /// Look Ranges of texts occurrences in all string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Ranges of texts occurrences in all string (if not find any, return empty array)
    func ocurrencesRanges(_ text: String,
                          options: String.CompareOptions = [],
                          range: Range<Index>? = nil,
                          locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: text,
                                                  options: options,
                                                  range: start..<end,
                                                  locale: locale ?? .current) {
                                                    ranges.append(NSRange(range, in: self))
                                                    start = range.upperBound
        }
        return ranges
    }

    var bodyRange: NSRange {
        nsRange(of: self)!
    }

    func nsRange(of string: String) -> NSRange? {
        guard let range = self.range(of: string, options: [], range: startIndex..<endIndex, locale: .current) else {
            return nil
        }
        return NSRange(range, in: self)
    }

    /// Format the string by slicing in equal segments with given separator
    func separating(every: Int, with separator: Character = " ") -> String {
        let charactersWithSeparator = enumerated()
            .map { $0 > 0 && $0 % every == 0 ? [separator, $1] : [$1] }

        return String(charactersWithSeparator.joined())
    }
}
