import Combine
import Foundation

public extension Publisher where Output == Bool {
    /// Ignore al false values, pass only trues
    func filterFalses() -> Publishers.FilterFalses<Self> {
        Publishers.FilterFalses(upstream: self)
    }
}

public extension Publishers {
    struct FilterFalses<Upstream: Publisher>: Publisher where Upstream.Output == Bool {
        public typealias Output = Bool
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

extension Publishers.FilterFalses {
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
            switch input {
            case true:
                return downstream.receive(input)

            case false:
                return .none
            }
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
