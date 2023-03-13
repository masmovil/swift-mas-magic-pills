import Combine
import MasMagicPills
import XCTest

class PublishersMapToVoidTests: XCTestCase {
    func test_map_to_void() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")

        Just("patata")
            .mapToVoid()
            .sink { value in
                XCTAssertTrue(value is Void)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
    }
}
