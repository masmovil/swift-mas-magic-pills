import Combine
import Foundation

public extension PassthroughSubject where Output == String {
    func sendType<T>(_ type: T.Type, tag: String = "") {
        send("\(type.self)-\(tag)")
    }

    func filterType<T>(_ type: T.Type, tag: String = "") -> Publishers.Filter<PassthroughSubject<Output, Failure>> {
        filter { $0 == "\(type.self)-\(tag)" }
    }
}
