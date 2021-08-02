import Foundation
import MasMagicPills
import XCTest

class EncodableExtensionsTests: XCTestCase {
    func test_parse_encodable_to_dictionary() {
        struct EncodableObject: Encodable {
            let name: String
            let age: Int
            let weight: Float
        }

        let encodableObject = EncodableObject(name: "Peter",
                                              age: 38,
                                              weight: 89.5)

        let dictionary = try? encodableObject.asDictionary()

        XCTAssertEqual(dictionary?["name"] as? String, "Peter")
        XCTAssertEqual(dictionary?["age"] as? Int, 38)
        XCTAssertEqual(dictionary?["weight"] as? Float, 89.5)
    }
}
