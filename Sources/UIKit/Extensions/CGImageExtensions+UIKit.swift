import Foundation

public extension CGImage {
    var uiImage: UIImage {
        UIImage(cgImage: self)
    }
}
