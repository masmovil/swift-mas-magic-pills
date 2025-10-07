import Combine
import Foundation
import MasMagicPills
import XCTest

class PublishersExtensionsTests: XCTestCase {
    func test_flat_map_latest() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        expectation.expectedFulfillmentCount = 3

        let subject1 = PassthroughSubject<Int, Never>()
        let subject2 = PassthroughSubject<String, Never>()

        subject1
            .flatMapLatest { value1 in
                subject2
                    .map { value2 in "\(value2) (\(value1)))" }
                    .eraseToAnyPublisher()
            }
            .sink { values in
                print("received \(values)")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        subject1.send(4)
        subject2.send("hi1")   // 1
        subject1.send(5)
        subject1.send(7)
        subject2.send("hi2")  // 2
        subject2.send("hi3")  // 3

        waitForExpectations(timeout: 3)
    }
}
