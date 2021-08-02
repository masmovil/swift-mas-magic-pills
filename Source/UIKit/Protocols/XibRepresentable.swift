import Foundation

/// Used to link a View with his XIB that use the same name.
public protocol XibRepresentable: AnyObject {
    static var xibName: String { get }
    static func xib(bundle: Bundle?) -> UINib
}

public extension XibRepresentable {
    static var xibName: String {
        String(describing: self)
    }

    static func xib(bundle: Bundle? = nil) -> UINib {
        UINib(nibName: xibName, bundle: bundle)
    }
}
