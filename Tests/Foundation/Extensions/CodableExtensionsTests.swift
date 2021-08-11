import Foundation
import MasMagicPills
import XCTest

class CodableExtensionsTests: XCTestCase {
    func test_parse_encodable_to_dictionary() {
        let encodableObject = CodableTestObject(name: "Peter", age: 38, weight: 89.5)

        let dictionary = try? encodableObject.asDictionary()

        XCTAssertEqual(dictionary?["name"] as? String, "Peter")
        XCTAssertEqual(dictionary?["age"] as? Int, 38)
        XCTAssertEqual(dictionary?["weight"] as? Float, 89.5)
    }

    func test_encode_decode_jsonstring() {
        let encodableObject = CodableTestObject(name: "Peter", age: 38, weight: 89.5)

        let json = encodableObject.jsonString
        XCTAssertNotNil(json)

        let object = CodableTestObject.decode(jsonString: json)
        XCTAssertEqual(object, encodableObject)
    }
}
