import Combine
import MasMagicPills
import XCTest

class CurrentValueSubjectTests: XCTestCase {
    func test_send_if_distinct() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        expectation.expectedFulfillmentCount = 2

        let subject = CurrentValueSubject<String, Never>("Hi")

        subject
            .sink { value in
                print("received \(value)")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        subject.sendIfDistinct("Hi")
        subject.sendIfDistinct("Bye")

        waitForExpectations(timeout: 10)
    }
}
