import Foundation

public extension Encodable {
    func jsonString() throws -> String {
        guard let data = try? JSONEncoder().encode(self) else {
            throw MagicError.invalidInput
        }
        guard let json = String(data: data, encoding: String.Encoding.utf8) else {
            throw MagicError.cantCreateOutput
        }
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
    static func decode(jsonString: String) throws -> Self {
        try decode(jsonString: (jsonString as String?))
    }

    static func decode(jsonString: String?) throws -> Self {
        guard let json = jsonString else {
            throw MagicError.invalidInput
        }
        let data = json.dataUTF8
        return try JSONDecoder().decode(self, from: data)
    }
}
