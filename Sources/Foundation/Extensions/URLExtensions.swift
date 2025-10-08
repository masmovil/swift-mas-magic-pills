import Foundation

public extension URL {
    init?(phone: String) {
        let phone = phone.removingWhiteSpacesAndPercentEncoding
            .lowercased()
            .removing(prefix: "tel://")
            .removing(prefix: "tel:")
        guard phone.isValidForPhoneDialer else { return nil }
        self.init(string: "tel:\(phone)")
    }

    init?(email: String) {
        let email = email.removingWhiteSpacesAndPercentEncoding
            .lowercased()
            .removing(prefix: "mailto://")
            .removing(prefix: "mailto:")
        guard email.isValidEmail else { return nil }
        self.init(string: "mailto:\(email)")
    }

    func sanitizedPhoneUrl() -> URL? {
        URL(phone: removingQuery.absoluteString)
    }

    func sanitizedEmailUrl() -> URL? {
        URL(email: removingQuery.absoluteString)
    }

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
        guard scheme?.lowercased() == "mailto" else { return false }
        guard let url = sanitizedEmailUrl() else { return false }
        return url.removingQuery.absoluteString.replacingOccurrences(of: "mailto:", with: "").isValidEmail
    }

    var isClickToCall: Bool {
        guard scheme?.lowercased() == "tel" else { return false }
        guard let url = sanitizedPhoneUrl() else { return false }
        return url.absoluteString.replacingOccurrences(of: "tel:", with: "").isValidForPhoneDialer
    }

    /// If the URL is a ClickToCall URL, returns the email destination
    var clickToCallDestination: String? {
        guard isClickToCall else { return nil }
        guard let scheme = scheme else { return nil }
        guard let url = sanitizedPhoneUrl() else { return nil }
        if absoluteString.hasPrefix("\(scheme):\\") {
            return url.absoluteString.removing(prefix: "\(scheme):\\")
        }
        if absoluteString.hasPrefix("\(scheme):") {
            return url.absoluteString.removing(prefix: "\(scheme):")
        }
        return nil
    }

    /// If the URL is a MailTo URL, returns the email destination
    var mailToDestination: String? {
        guard isMailTo else { return nil }
        guard let scheme = scheme else { return nil }
        guard let url = sanitizedEmailUrl() else { return nil }
        if absoluteString.hasPrefix("\(scheme):\\") {
            return url.absoluteString.removing(prefix: "\(scheme):\\")
        }
        if absoluteString.hasPrefix("\(scheme):") {
            return url.absoluteString.removing(prefix: "\(scheme):")
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
