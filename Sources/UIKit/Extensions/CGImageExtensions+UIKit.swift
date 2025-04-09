#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

public extension CGImage {
    #if canImport(UIKit)
    var uiImage: UIImage {
        UIImage(cgImage: self)
    }
    #endif
}
