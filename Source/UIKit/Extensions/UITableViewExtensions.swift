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

    /// Dequeue reusable UITableViewCell using class name.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
