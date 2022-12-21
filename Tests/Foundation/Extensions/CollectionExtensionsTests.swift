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
        let elements = [HIdent(id: "1"), HIdent(id: "1"), HIdent(id: "2")]

        let enumerated = elements.enumeratedArray()

        XCTAssertEqual(enumerated[0].index, 0)
        XCTAssertEqual(enumerated[0].id, "1")
        XCTAssertEqual(enumerated[1].index, 1)
        XCTAssertEqual(enumerated[1].id, "1")
        XCTAssertEqual(enumerated[2].index, 2)
        XCTAssertEqual(enumerated[2].id, "2")

        // All `IndexedItemIdentifiable` are `Hashable` & `Equatable`, for that reason its can be grouped by itself:
        let groupedByItem = Dictionary(grouping: enumerated) { $0 }

        // When the elements has two IDs repeated, these items are grouped together:
        XCTAssertEqual(groupedByItem.keys.map(\.id).sorted(), ["1", "2"])
        XCTAssertEqual(groupedByItem[enumerated[0]]?.count, 2)
        XCTAssertEqual(groupedByItem[enumerated[2]]?.count, 1)
    }
}
