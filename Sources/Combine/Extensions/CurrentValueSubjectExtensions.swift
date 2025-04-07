import Combine
import Foundation

public extension CurrentValueSubject where Output: Equatable {
    /// Emit new value if distinct, ignore
    func sendIfDistinct(_ input: Output) {
        if input != value {
            send(input)
        }
    }
}
