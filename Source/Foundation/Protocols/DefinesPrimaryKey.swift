import Foundation

public protocol DefinesPrimaryKey: Equatable {
    associatedtype PrimaryKey

    var primaryKey: PrimaryKey { get }
}

public func == <T: DefinesPrimaryKey>(lhs: T, rhs: T) -> Bool where T.PrimaryKey: Equatable {
    lhs.primaryKey == rhs.primaryKey
}
