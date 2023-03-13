import Combine
import MasMagicPills
import XCTest

class PublishersFilterFalsesTests: XCTestCase {
    func test_false() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        expectation.isInverted = true

        Just(false)
            .filterFalses()
            .sink { _ in
                XCTFail("Never be called")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }

    func test_true() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")

        Just(true)
            .filterFalses()
            .sink { value in
                XCTAssertTrue(value)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }
}
