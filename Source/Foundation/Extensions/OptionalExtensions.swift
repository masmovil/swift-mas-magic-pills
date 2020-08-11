import Foundation

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
}

public extension Optional where Wrapped == Bool {
    /// returns true when the actual value is logically true.
    var isTruthy: Bool {
        if let value = self {
            return value
        }
        return false
    }

    /// returns true when the actual value is not logically true.
    var isFalsy: Bool {
        if let value = self {
            return value.isFalse
        }
        return false
    }
}

/// Generic method to compare array of nullable Equatable values.
func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

/// Generic method to compare array of nullable Optional(nullables) values.
func ==<T: OptionalType>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}
