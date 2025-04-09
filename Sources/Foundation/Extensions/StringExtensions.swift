import Foundation

public extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Common") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }

    func starts(withAnyOf: [String]) -> Bool {
        withAnyOf.contains { starts(with: $0) }
    }

    /// Format the string by slicing in equal segments with given separator
    func separating(every: Int, with separator: Character = " ") -> String {
        let charactersWithSeparator = enumerated()
            .map { $0 > 0 && $0 % every == 0 ? [separator, $1] : [$1] }

        return String(charactersWithSeparator.joined())
    }
}
