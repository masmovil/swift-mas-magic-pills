import Combine
import Foundation

public extension Publisher {
    /// Convert stream to result, wraping failures and avoiding terminating the downstream.
    func mapToResult() -> Publishers.MapToResult<Self> {
        Publishers.MapToResult(upstream: self)
    }
}

public extension Collection {
    func mapToResults<S, F>() -> [Publishers.MapToResult<Element>]
    where Element: Publisher<S, F> {
        map { $0.mapToResult() }
    }
}

public extension Publishers {
    struct MapToResult<Upstream: Publisher>: Publisher {
        public typealias Output = Result<Upstream.Output, Upstream.Failure>
        public typealias Failure = Never

        public let upstream: Upstream

        public init(upstream: Upstream) {
            self.upstream = upstream
        }

        public func receive<Downstream: Subscriber>(subscriber: Downstream)
        where Output == Downstream.Input, Downstream.Failure == Failure {
            upstream.subscribe(Inner(downstream: subscriber))
        }
    }
}

extension Publishers.MapToResult {
    private struct Inner<Downstream: Subscriber>: Subscriber
    where Downstream.Input == Output, Downstream.Failure == Never {
        typealias Input = Upstream.Output
        typealias Failure = Upstream.Failure

        private let downstream: Downstream

        let combineIdentifier = CombineIdentifier()

        fileprivate init(downstream: Downstream) {
            self.downstream = downstream
        }

        func receive(subscription: Subscription) {
            downstream.receive(subscription: subscription)
        }

        func receive(_ input: Input) -> Subscribers.Demand {
            downstream.receive(.success(input))
        }

        func receive(completion: Subscribers.Completion<Failure>) {
            switch completion {
            case .finished:
                downstream.receive(completion: .finished)

            case .failure(let error):
                _ = downstream.receive(.failure(error))
                downstream.receive(completion: .finished)
            }
        }
    }
}
