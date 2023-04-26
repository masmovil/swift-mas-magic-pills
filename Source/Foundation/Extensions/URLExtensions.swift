import Foundation

public extension URL {
    func appendingItems(items: [URLQueryItem]) throws -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            throw MagicError.badRequest
        }
        components.queryItems = items
        guard let urlWithQuery = components.url else {
            throw MagicError.badRequest
        }
        return urlWithQuery
    }

    func lowercased() -> URL {
        let string = absoluteString.lowercased()
        return string.urlValue!
    }

    var typeIdentifier: String? {
        (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }

    var localizedName: String? {
        (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }

    var isMailto: Bool {
        guard scheme == "mailto" else { return false }
        return absoluteString.replacingOccurrences(of: "mailto:", with: "").isValidEmail
    }

    var isClickToCall: Bool {
        guard scheme == "tel" else { return false }
        return absoluteString.replacingOccurrences(of: "tel:", with: "").isValidForPhoneDialer
    }
}

extension URL: Comparable {
    public static func < (lhs: URL, rhs: URL) -> Bool {
        lhs.absoluteString < rhs.absoluteString
    }
}
