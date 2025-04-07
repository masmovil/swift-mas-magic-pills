import Foundation

public extension URL {
    func appendingFragment(_ fragment: String?) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true) ?? URLComponents()
        components.fragment = fragment
        return components.url ?? self
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

    var isMailTo: Bool {
        guard scheme == "mailto" else { return false }
        return removingQuery.absoluteString.replacingOccurrences(of: "mailto:", with: "").isValidEmail
    }

    var isClickToCall: Bool {
        guard scheme == "tel" else { return false }
        return absoluteString.replacingOccurrences(of: "tel:", with: "").isValidForPhoneDialer
    }

    /// Is the value is a ClickToCall URL, returns the phone number
    var clickToCallDestination: String? {
        guard isClickToCall else { return nil }
        guard let scheme = scheme else { return nil }
        if absoluteString.hasPrefix("\(scheme):\\") {
            return absoluteString.removing(prefix: "\(scheme):\\")
        }
        if absoluteString.hasPrefix("\(scheme):") {
            return absoluteString.removing(prefix: "\(scheme):")
        }
        return nil
    }

    /// Is the value is a MailTo URL, returns the email
    var mailToDestination: String? {
        guard isMailTo else { return nil }
        guard let scheme = scheme else { return nil }
        if absoluteString.hasPrefix("\(scheme):\\") {
            return removingQuery.absoluteString.removing(prefix: "\(scheme):\\")
        }
        if absoluteString.hasPrefix("\(scheme):") {
            return removingQuery.absoluteString.removing(prefix: "\(scheme):")
        }
        return nil
    }

    /// Return the same url without query params
    var removingQuery: URL {
        if var components = URLComponents(string: absoluteString) {
            components.query = nil
            return components.url ?? self
        }

        return self
    }

    /// Retrieve the resource of the url (or the absolute string if not available)
    var resourceSpecifier: String {
        (self as NSURL).resourceSpecifier ?? absoluteString
    }

    func checkIsReachableOnInternet() async -> Bool {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"

        let session = URLSession(configuration: .ephemeral)
        defer { session.invalidateAndCancel() }

        guard let (_, response) = try? await session.data(for: request),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }
}

extension URL: Comparable {
    public static func < (lhs: URL, rhs: URL) -> Bool {
        lhs.absoluteString < rhs.absoluteString
    }
}

public extension [URL] {
    func filterUnreachableUrls() async -> [URL] {
        var result = [URL]()
        for url in self where await url.checkIsReachableOnInternet() {
            result.append(url)
        }
        return result
    }
}
