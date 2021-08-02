import Foundation

public extension Encodable {
    var jsonString: String? {
        guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { return nil }
        return json
    }
}

public extension Decodable {
    static func decode(jsonString: String) -> Self? {
        let data = jsonString.dataUTF8
        return try? JSONDecoder().decode(self, from: data)
    }
}
