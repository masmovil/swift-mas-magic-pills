import Combine
import Foundation
import MasMagicPills
import XCTest

class PassthroughSubjectTests: XCTestCase {
    func test_send_type_and_filter_type() {
        var cancellables = Set<AnyCancellable>()
        let expectation1 = expectation(description: "wait for async process")
        let expectation2 = expectation(description: "wait for async process")

        let subject = PassthroughSubject<String, Never>()

        subject
            .filterType(String.self)
            .sink { value in
                print("received \(value)")
                expectation1.fulfill()
            }
            .store(in: &cancellables)

        subject
            .filterType(Decimal.self)
            .sink { value in
                print("received \(value)")
                expectation2.fulfill()
            }
            .store(in: &cancellables)

        subject.sendType(Decimal.self)
        subject.sendType(String.self)

        waitForExpectations(timeout: 10)
    }
}
