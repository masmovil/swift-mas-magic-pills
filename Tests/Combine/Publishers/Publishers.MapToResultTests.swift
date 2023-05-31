import Combine
import MasMagicPills
import XCTest

class PublishersMapToResultTests: XCTestCase {
    func test_value() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        let expectedValue = "value"

        Just(expectedValue)
            .mapToResult()
            .sink { value in
                XCTAssertEqual(value, .success(expectedValue))
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }

    func test_error() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        let expectedError = MagicError.invalidInput

        Fail<String, MagicError>(error: expectedError)
            .mapToResult()
            .sink { value in
                XCTAssertEqual(value, .failure(.invalidInput))
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }

    func test_finish_publishers() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")
        let one: AnyPublisher<String, MagicError> = Fail<String, MagicError>(error: .invalidInput).eraseToAnyPublisher()
        let two: AnyPublisher<String, MagicError> = Just("2").setFailureType(to: MagicError.self).eraseToAnyPublisher()

        Publishers.MergeMany([one, two].mapToResults())
            .collect()
            .sink { values in
                XCTAssertEqual(values, [.failure(.invalidInput), .success("2")])
                XCTAssertEqual(values.failureErrors(), [.invalidInput])
                XCTAssertEqual(values.successValues(), ["2"])
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }
}
