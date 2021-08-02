import UIKit

public extension UITableView {
    /// Register UITableViewCell using class name.
    ///
    /// - Parameter type: UITableViewCell type.
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Register UITableViewCell with .xib file using only its corresponding class.
    ///     Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameter type: UITableViewCell type.
    func registerWithNib<T: UITableViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        register(T.xib(bundle: bundle), forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Register UITableViewHeaderFooterView file using only its corresponding class.
    ///
    /// - Parameter type: UIView type.
    func registerHeaderFooter<H: UITableViewHeaderFooterView>(_ type: H.Type) {
        register(H.self, forHeaderFooterViewReuseIdentifier: H.reuseIdentifier)
    }

    /// Register UITableViewHeaderFooterView with .xib file using only its corresponding class.
    ///     Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameter type: UIView type.
    func registerHeaderFooterWithNib<H: UITableViewHeaderFooterView>(_ type: H.Type, bundle: Bundle? = nil) {
        register(H.xib(bundle: bundle), forHeaderFooterViewReuseIdentifier: H.reuseIdentifier)
    }

    /// Dequeue reusable UITableViewCell using class name.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.xibName)/\(T.reuseIdentifier) could not be dequeued for \(indexPath) as \(T.self)")
        }

        return cell
    }

    /// Dequeue reusable UITableViewCell using class name.
    ///
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("\(T.xibName)/\(T.reuseIdentifier) could not be dequeued as \(T.self)")
        }

        return cell
    }

    /// Dequeue reusable UITableViewHeaderFooterView using class name.
    ///
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableHeaderFooterView<H: UITableViewHeaderFooterView>() -> H {
        guard let headerView = dequeueReusableHeaderFooterView(withIdentifier: H.reuseIdentifier) as? H else {
            fatalError("\(H.xibName)/\(H.reuseIdentifier) could not be dequeued as \(H.self)")
        }
        return headerView
    }
}
