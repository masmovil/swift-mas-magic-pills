import Foundation
import MasMagicPills
import XCTest

class JWTTests: XCTestCase {
    private let jsonHelper = JSONTestHelper()

    func test_init_from_basic_token() {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

        let jwt = JWT(rawValue: token)

        XCTAssertEqual(jwt?.rawValue, token)
        XCTAssertEqual(jwt?.subject, "1234567890")
        XCTAssertEqual(jwt?.body["name"] as? String, "John Doe")
        XCTAssertEqual(jwt?.body["iat"] as? Int, 1_516_239_022)
        XCTAssertEqual(jwt?.issuedAt, Date(timeIntervalSince1970: 1_516_239_022))

        XCTAssertNil(jwt?.expiresAt)
        XCTAssertEqual(jwt?.isExpired, false)
    }

    func test_encode_decode() {
        let jwt = JWT(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkZpcnVsYWlzIiwiaWF0IjoxMjc0ODgxMjQsImV4cCI6MTI5MTI0NjQ2fQ.ZGzsQMIQNhYidL7CsdOu-ng3lOfXqbMo6HCT-Ya2jZ8")
        let error1 = jsonHelper.unparseAndParse(jwt)
        XCTAssertNil(error1)
    }

    func test_token_with_audience_and_expiration_in_the_past() {
        let jwt = JWT(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkZpcnVsYWlzIiwiaWF0IjoxMjc0ODgxMjQsImV4cCI6MTI5MTI0NjQ2LCJhdWQiOlsib25lIiwidHdvIl19.mLdc29x6TeERFtKtCdTWo921DPyvGJZzLQ8rGEr-7DM")
        XCTAssertEqual(jwt?.audience, ["one", "two"])
        XCTAssertEqual(jwt?.isExpired, true)
    }

    func test_init_from_invalid_token() {
        XCTAssertNil(JWT(rawValue: "wawawa"))
        XCTAssertNil(JWT(rawValue: "wa.we.wi"))
        XCTAssertNil(JWT(rawValue: ""))
        XCTAssertNil(JWT(rawValue: "🤷"))
    }

    func test_init_HS256_token() {
        let jwt = try? JWT(HMACSHA256Claims: ["sub": "hola"], secret: "jijiji")
        XCTAssertEqual(jwt?.rawValue, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJob2xhIn0.dXg3SitnRVRjMjV3dnFHRGwzQkZzK203RUlOVkFRR3F6UzRhZW1Sd09mUT0")
        XCTAssertEqual(jwt?.subject, "hola")
    }
}
