import Foundation
import MasMagicPills
import XCTest

class ResultExtensionsTests: XCTestCase {
    func test_success_helpers() {
        let result = Result<String, MagicError>.success("hola")

        XCTAssertFalse(result.isFailure)
        XCTAssertTrue(result.isSuccess)
        XCTAssertEqual(result.successValue, "hola")
        XCTAssertNil(result.failureError)
    }

    func test_failure_helpers() {
        let result = Result<String, MagicError>.failure(.badRequest)

        XCTAssertTrue(result.isFailure)
        XCTAssertFalse(result.isSuccess)
        XCTAssertEqual(result.failureError, .badRequest)
        XCTAssertNil(result.successValue)
    }
}
