import Foundation

/// Wrapper class to allow pass dictionaries has a memory reference
public class SharedDictionary<Key: Hashable, Value> {
    public var innerDictionary: [Key: Value]

    public init() {
        innerDictionary = [:]
    }

    public func safeValue(_ key: Key, defaultValue: () -> Value) -> Value {
        self[key, ifNotExistsSave: defaultValue]
    }

    public func value(withKey key: Key) -> Value? {
        self[key]
    }

    public subscript (_ key: Key, ifNotExistsSave defaultValue: () -> Value) -> Value {
        innerDictionary.safeValue(key, defaultValue: defaultValue)
    }

    public subscript (_ key: Key) -> Value? {
        innerDictionary[key]
    }
}
