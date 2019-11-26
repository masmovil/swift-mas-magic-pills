import Foundation

/// Used to link a View with his XIB that use the same name.
public protocol CellIdentificable: class {
    static var reuseIdentifier: String { get }
}

public extension CellIdentificable {
    static var reuseIdentifier: String {
        return "\(String(describing: self))ID"
    }
}
