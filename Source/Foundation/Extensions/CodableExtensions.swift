import Foundation

public extension Encodable {
    var jsonString: String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = String(data: data, encoding: String.Encoding.utf8) else { return nil }
        return json
    }

    /// Return encodable object like a dictionary
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw MagicError.cantConvertToDictionary
        }
        return dictionary
    }
}

public extension Decodable {
    static func decode(jsonString: String) -> Self? {
        decode(jsonString: (jsonString as String?))
    }

    static func decode(jsonString: String?) -> Self? {
        guard let json = jsonString else { return nil }
        let data = json.dataUTF8
        return try? JSONDecoder().decode(self, from: data)
    }
}
