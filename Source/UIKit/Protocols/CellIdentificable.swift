import Foundation

/// Used to identify a View to generate a reusable identifier for tables and collections view.
public protocol CellIdentificable: class {
    static var reuseIdentifier: String { get }
}

public extension CellIdentificable {
    static var reuseIdentifier: String {
        return "\(String(describing: self))ID"
    }
}
