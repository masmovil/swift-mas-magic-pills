import Foundation

public extension URL {
    var typeIdentifier: String? {
        (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }

    var localizedName: String? {
        (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }

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
}

extension URL: Comparable {
    public static func < (lhs: URL, rhs: URL) -> Bool {
        lhs.absoluteString < rhs.absoluteString
    }
}
