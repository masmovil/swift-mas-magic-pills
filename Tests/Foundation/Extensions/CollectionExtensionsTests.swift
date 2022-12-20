import Foundation
import MasMagicPills
import XCTest

class CollectionExtensionsTests: XCTestCase {
    func test_isNotEmpty() {
        var collection = [String]()
        XCTAssertFalse(collection.isNotEmpty)

        collection.append("hi")
        XCTAssertTrue(collection.isNotEmpty)

        collection.removeAll()
        XCTAssertFalse(collection.isNotEmpty)
    }

    func test_enumerated_array_non_identifiable() {
        let elements = ["hola", "chau", "adios"]

        let enumerated = elements.enumeratedArray()
        XCTAssertEqual(enumerated[0].index, 0)
        XCTAssertEqual(enumerated[0].item, "hola")
        XCTAssertEqual(enumerated[1].index, 1)
        XCTAssertEqual(enumerated[1].item, "chau")
        XCTAssertEqual(enumerated[2].index, 2)
        XCTAssertEqual(enumerated[2].item, "adios")
    }

    func test_enumerated_array_identifiable() {
        struct HIdent: Identifiable {
            let id: String
        }
        let elements = [HIdent(id: "h"), HIdent(id: "g"), HIdent(id: "6")]

        let enumerated = elements.enumeratedArray()
        XCTAssertEqual(enumerated[0].index, 0)
        XCTAssertEqual(enumerated[0].id, "h")
        XCTAssertEqual(enumerated[1].index, 1)
        XCTAssertEqual(enumerated[1].id, "g")
        XCTAssertEqual(enumerated[2].index, 2)
        XCTAssertEqual(enumerated[2].id, "6")
    }
}
