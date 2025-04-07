import Foundation

public extension CIImage {
    var uiImage: UIImage {
        UIImage(ciImage: self)
    }
}
