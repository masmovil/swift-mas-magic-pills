import Foundation

public extension Data {
    var stringUTF8: String? {
        NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
    }
}
