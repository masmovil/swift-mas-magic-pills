#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UICollectionView {
    /// Register UICollectionViewCell using class name.
    ///
    /// - Parameter type: UICollectionViewCell type.
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /// Register UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }

    /// Register UICollectionViewCell with .xib file using only its corresponding class.
    ///     Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameter type: UICollectionViewCell type.
    func registerWithNib<T: UICollectionViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        register(T.xib(bundle: bundle), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /// Dequeue reusable UICollectionViewCell using class name.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.xibName)/\(T.reuseIdentifier) could not be dequeued for \(indexPath) as \(T.self)")
        }
        return cell
    }

    /// Dequeue reusable UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionReusableView object with associated class name.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.xibName)/\(T.reuseIdentifier) could not be dequeued for \(indexPath) as \(T.self)")
        }
        return view
    }
}
#endif
