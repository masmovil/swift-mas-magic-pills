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

    func test_enumerated_array_with_non_identifiable_items() {
        let elements = ["hola", "chau", "adios"]

        let enumerated: [IndexedItem<Int, String>] = elements.enumeratedArray()

        // Check first element:
        XCTAssertEqual(enumerated[0].index, 0)
        XCTAssertEqual(enumerated[0].id, enumerated[0].index)
        XCTAssertEqual(enumerated[0].value, "hola")

        // Check second element:
        XCTAssertEqual(enumerated[1].index, 1)
        XCTAssertEqual(enumerated[1].id, enumerated[1].index)
        XCTAssertEqual(enumerated[1].value, "chau")

        // Check third element:
        XCTAssertEqual(enumerated[2].index, 2)
        XCTAssertEqual(enumerated[2].id, enumerated[2].index)
        XCTAssertEqual(enumerated[2].value, "adios")

        // Check Hashable & Equatable capability:
        // All `IndexedItem` are `Hashable` & `Equatable`, for that reason its can be grouped by itself:
        let groupedByItem = Dictionary(grouping: enumerated) { $0 }

        XCTAssertEqual(groupedByItem.keys.count, 3)
        XCTAssertEqual(groupedByItem[enumerated[0]]?.count, 1)
        XCTAssertEqual(groupedByItem[enumerated[1]]?.count, 1)
        XCTAssertEqual(groupedByItem[enumerated[2]]?.count, 1)
    }

    func test_enumerated_array_with_identifiable_items() {
        struct HIdent: Identifiable, Equatable {
            let id: String
            let val: String
        }
        let elements = [HIdent(id: "1", val: "o1"),
                        HIdent(id: "1", val: "o2"),
                        HIdent(id: "2", val: "o3")]

        let enumerated = elements.enumeratedArray()

        // Check First element on First Index:
        XCTAssertEqual(enumerated[0].index, 0)
        XCTAssertEqual(enumerated[0].id, elements[0].id)
        XCTAssertEqual(enumerated[0].value, elements[0])

        // Check Second element on Second Index:
        XCTAssertEqual(enumerated[1].index, 1)
        XCTAssertEqual(enumerated[1].id, elements[1].id)
        XCTAssertEqual(enumerated[1].value, elements[1])

        // Check Third element on Third Index:
        XCTAssertEqual(enumerated[2].index, 2)
        XCTAssertEqual(enumerated[2].id, elements[2].id)
        XCTAssertEqual(enumerated[2].value, elements[2])

        // Check Hashable & Equatable capability:
        // All `IndexedItemIdentifiable` are `Hashable` & `Equatable`, for that reason its can be grouped by itself:
        let groupedByItem = Dictionary(grouping: enumerated) { $0 }

        // When the elements has two IDs repeated, these items are grouped together (The ID of the Identifiable is the identity):
        XCTAssertEqual(groupedByItem.keys.map(\.id).sorted(), ["1", "2"])
        XCTAssertEqual(groupedByItem[enumerated[0]]?.count, 2)
        XCTAssertEqual(groupedByItem[enumerated[2]]?.count, 1)
    }
}
