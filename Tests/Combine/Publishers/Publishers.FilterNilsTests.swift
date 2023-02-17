import Combine
import MasMagicPills
import XCTest

class PublishersFilterNilsTests: XCTestCase {
    func test_filternils() {
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "wait for async process")

        let inputData: [String?] = [nil, "hola", "chau", "nil", nil]
        let expectedOutput = ["hola", "chau", "nil"]

        Publishers.Sequence(sequence: inputData)
            .filterNils()
            .collect()
            .sink { value in
                XCTAssertEqual(value, expectedOutput)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
    }
}
