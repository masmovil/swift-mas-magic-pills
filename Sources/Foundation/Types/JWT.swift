import CommonCrypto
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

    public init(HMACSHA256Claims claims: [String: Any], secret: String) throws {
        let encodedHeader = try JWT.encodeJWTPart(["alg": "HS256", "typ": "JWT"])
        let encodedBody = try JWT.encodeJWTPart(claims)
        let unsignedToken = "\(encodedHeader).\(encodedBody)"
        let signature = unsignedToken.hmac(.sha256(secret: secret))

        try self.init(token: "\(unsignedToken).\(signature.base64UrlEncoded)")
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

    private static func encodeJWTPart(_ value: [String: Any]) throws -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else {
            throw MagicError.invalidInput
        }
        guard let json = String(data: jsonData, encoding: .utf8) else {
            throw MagicError.invalidInput
        }
        return json.base64UrlEncoded
    }

    private static func decodeJWTPart(_ value: String) throws -> [String: Any] {
        guard let json = value.base64UrlDecoded else {
            throw MasMagicPills.MagicError.invalidInput
        }

        guard let json = try? JSONSerialization.jsonObject(with: json.dataUTF8, options: []),
              let payload = json as? [String: Any] else {
            throw MasMagicPills.MagicError.invalidInput
        }

        return payload
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
