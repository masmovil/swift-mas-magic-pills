#if canImport(UIKit)
import UIKit
#endif

/// Used to link a View with his XIB that use the same name.
public protocol XibRepresentable: AnyObject {
    static var xibName: String { get }
    #if canImport(UIKit) && !os(watchOS)
    static func xib(bundle: Bundle?) -> UINib
    #endif
}

public extension XibRepresentable {
    static var xibName: String {
        String(describing: self)
    }

    #if canImport(UIKit) && !os(watchOS)
    static func xib(bundle: Bundle? = nil) -> UINib {
        UINib(nibName: xibName, bundle: bundle)
    }
    #endif
}
