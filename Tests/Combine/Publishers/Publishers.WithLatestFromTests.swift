import Combine
import MasMagicPills
import XCTest

class PublishersWithLatestFromTests: XCTestCase {
    func test_with_latest_from() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        expectation.expectedFulfillmentCount = 4

        let subject1 = PassthroughSubject<Int, Never>()
        let subject2 = CurrentValueSubject<String, Never>("hi0")

        subject1
            .withLatestFrom(subject2)
            .sink { values in
                print("received \(values)")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        subject1.send(4)
        subject2.send("hi1")   // 1
        subject1.send(5)
        subject1.send(7)
        subject2.send("hi2")   // 2
        subject2.send("hi3")   // 3
        subject1.send(9)

        waitForExpectations(timeout: 3)
    }
}
