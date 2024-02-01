import Foundation

public extension URLComponents {
    /// Fetch string value of given queryItem key. Return nil if not found.
    subscript(queryItem queryItem: String) -> String? {
        guard let queryItem = queryItems?.first(where: { $0.name.lowercased() == queryItem.lowercased() }),
              let itemValue = queryItem.value
        else {
            return nil
        }

        return itemValue
    }
}
