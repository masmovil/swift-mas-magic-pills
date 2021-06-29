public extension Encodable {
    /// Return encodable object like a dictionary
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw MagicError.cantConvertToDictionary
        }
        return dictionary
    }
}
