#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif

#if canImport(UIKit) && !os(watchOS)
public extension CIImage {
    var uiImage: UIImage {
        UIImage(ciImage: self)
    }
}
#endif
