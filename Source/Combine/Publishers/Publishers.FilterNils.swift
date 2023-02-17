import Combine
import Foundation

public extension Publisher where Output: OptionalType {
    /// Ignore all `nil` values and return the Wrapped type.
    func filterNils() -> Publishers.FilterNils<Self> {
        Publishers.FilterNils(upstream: self)
    }
}

public extension Publishers {
    struct FilterNils<Upstream: Publisher>: Publisher where Upstream.Output: OptionalType {
        public typealias Output = Upstream.Output.Wrapped
        public typealias Failure = Upstream.Failure

        public let upstream: Upstream

        public init(upstream: Upstream) {
            self.upstream = upstream
        }

        public func receive<Downstream: Subscriber>(subscriber: Downstream)
            where Output == Downstream.Input, Downstream.Failure == Upstream.Failure {
            upstream.subscribe(Inner(downstream: subscriber))
        }
    }
}

extension Publishers.FilterNils {
    private struct Inner<Downstream: Subscriber>: Subscriber, CustomStringConvertible, CustomReflectable, CustomPlaygroundDisplayConvertible
    where Downstream.Input == Output, Downstream.Failure == Upstream.Failure {
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
            if let value = input.wrapped {
                return downstream.receive(value)
            }
            return .none
        }

        func receive(completion: Subscribers.Completion<Failure>) {
            downstream.receive(completion: completion)
        }

        var description: String { "FilterNils" }

        var customMirror: Mirror {
            Mirror(self, children: EmptyCollection())
        }

        var playgroundDescription: Any { description }
    }
}
