import Combine
import Foundation

public extension Publisher {
    /**
     Projects each element from a publisher into a new publisher and then transforms an publisher into an publisher producing values only from the most recent value.
     - parameter transform: A transform function to apply to each element.
     - returns: A publisher whose elements are the result of invoking the transform function on each value of source producing a publisher and that at any point in time produces the elements of the most recent inner sequence that has been received.
     */
    func flatMapLatest<T>(_ transform: @escaping (Output) -> AnyPublisher<T, Failure>) -> AnyPublisher<T, Failure> {
        map(transform)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
