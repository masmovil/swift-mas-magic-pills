import Foundation

/// A representation of the given JWT token.
///
/// ## See Also
/// - [JWT.io](https://jwt.io)
public struct JWT: Codable, Equatable, RawRepresentable {
    public let rawValue: String
    public let header: [String: Any]
    public let body: [String: Any]
    public let signature: String?
    public let expiresAt: Date?
    public let issuer: String?
    public let subject: String?
    public let audience: [String]?
    public let issuedAt: Date?
    public let notBefore: Date?
    public let identifier: String?

    public init?(rawValue: String) {
        try? self.init(token: rawValue)
    }

    public init(token: String) throws {
        self.rawValue = token

        let parts = token.components(separatedBy: ".")
        guard parts.count == 3 else {
            throw MasMagicPills.MagicError.badRequest
        }

        self.header = try JWT.decodeJWTPart(parts[0])
        self.body = try JWT.decodeJWTPart(parts[1])
        self.signature = parts[2]
        self.expiresAt = JWT.parseClaimTo(date: body["exp"])
        self.issuer = body["iss"] as? String
        self.subject = body["sub"] as? String
        self.audience = JWT.parseClaimTo(arrayString: body["aud"])
        self.issuedAt = JWT.parseClaimTo(date: body["iat"])
        self.notBefore = JWT.parseClaimTo(date: body["nbf"])
        self.identifier = body["jti"] as? String
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let token = try container.decode(String.self)

        try self.init(token: token)
    }

    public var isExpired: Bool {
        guard let date = self.expiresAt else {
            return false
        }
        return date.compare(Date()) != ComparisonResult.orderedDescending
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }

    public static func == (lhs: JWT, rhs: JWT) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    private static func decodeJWTPart(_ value: String) throws -> [String: Any] {
        guard let bodyData = base64UrlDecode(value) else {
            throw MasMagicPills.MagicError.invalidInput
        }

        guard let json = try? JSONSerialization.jsonObject(with: bodyData, options: []),
              let payload = json as? [String: Any] else {
            throw MasMagicPills.MagicError.invalidInput
        }

        return payload
    }

    private static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    private static func parseClaimTo(arrayString value: Any?) -> [String]? {
        if let array = value as? [String] {
            return array
        }

        if let string = value as? String {
            return [string]
        }

        return nil
    }

    private static func parseClaimTo(date value: Any?) -> Date? {
        guard let timestamp = value as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSince1970: timestamp)
    }
}
