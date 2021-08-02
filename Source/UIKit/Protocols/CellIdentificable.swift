import Foundation

/// Used to identify a View to generate a reusable identifier for tables and collections view.
public protocol CellIdentificable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension CellIdentificable {
    static var reuseIdentifier: String {
        "\(String(describing: self))ID"
    }
}
