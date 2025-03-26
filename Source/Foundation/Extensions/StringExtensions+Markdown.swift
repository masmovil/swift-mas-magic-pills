import Foundation

public extension String {
    var markdownUtils: Markdown {
        Markdown(string: self)
    }

    struct Markdown {
        let string: String

        public func bold() -> String {
            "**\(string)**"
        }

        public func italic() -> String {
            "*\(string)*"
        }

        public func link(url: String) -> String {
            "[\(string)](\(url))"
        }

        public func strikethrough() -> String {
            "~~\(string)~~"
        }

        public func code() -> String {
            "`\(string)`"
        }

        public func codeBlock(language: String = "") -> String {
            "```\(language)\n\(string)\n```"
        }

        public func quote() -> String {
            "> \(string)"
        }

        public func heading(level: Int) -> String {
            let normalizeLevel = Swift.max(1, Swift.min(6, level))
            let prefix = String(repeating: "#", count: normalizeLevel)
            return "\(prefix) \(string)"
        }

        public func bulletList() -> String {
            string.split(separator: "\n")
                  .map { "- \($0)" }
                  .joined(separator: "\n")
        }

        public func numberedList() -> String {
            string.split(separator: "\n")
                  .enumerated()
                  .map { "\($0.offset + 1). \($0.element)" }
                  .joined(separator: "\n")
        }
    }
}
