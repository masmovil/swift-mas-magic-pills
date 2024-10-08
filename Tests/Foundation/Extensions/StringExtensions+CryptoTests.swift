import Foundation
import MasMagicPills
import XCTest

class StringExtensionsCryptoTests: XCTestCase {
    func test_md5() {
        XCTAssertEqual("hash, hash, baby!!".md5, "A6401501F421EC8CE65C8405915ADF0D")
    }

    func test_sha1() {
        XCTAssertEqual("📦".sha1, "221887727FDCBD9F648F2672CFD4F366264C8440")
    }

    func test_sha256() {
        XCTAssertEqual("hash, hash, baby!!!! :D".sha256, "5EEBACE75DEDB9C94BE1E72E1229B55A02DBE2D23E5FEE0756CE6CB96673BEEB")
        XCTAssertEqual("📦".sha256, "E68EBC94437CAF84F78CF166B90ABFF24ABF4E95F30897B2A90768B59BFC0A7B")
    }

    func test_sha512() {
        XCTAssertEqual("hi, this is more secure! ;)".sha512, "53CEA135E5859223C9DD6FC050D3E7FEBA51E43B00210B20E27E1BC5FD87E67971B6646044A7C2F188E89297BB0BCAB22F31517B66CBBF1C27A43D632289FE36")
    }

    func test_base64_encode_and_decode() {
        XCTAssertEqual("hola".base64encoded.base64decoded, "hola")
        XCTAssertEqual("chau".base64encoded.base64decoded, "chau")
        XCTAssertEqual("😘".base64encoded.base64decoded, "😘")
        XCTAssertNil("bad base64 string".base64decoded)
    }

    func test_hmac_sha256_hash() {
        XCTAssertEqual("Prueba".hmac(.sha256(secret: "this-is-a-signing-key-for-HS256-jijiji")),
                       "BopCTSSzXNmUx6009cioMF2PJD/F+Gp0EOC3ajN4jI0=")
    }
}
