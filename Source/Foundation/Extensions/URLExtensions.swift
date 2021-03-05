import Foundation

public extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }

    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
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
}

extension URL: Comparable {
    public static func < (lhs: URL, rhs: URL) -> Bool {
        return lhs.absoluteString < rhs.absoluteString
    }
}
