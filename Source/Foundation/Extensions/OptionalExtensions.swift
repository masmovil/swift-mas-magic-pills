import Foundation

public extension Optional {
    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool {
        !isNil
    }

    var describingString: String {
        guard let value = self else {
            return "nil"
        }
        return "\(value)"
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
