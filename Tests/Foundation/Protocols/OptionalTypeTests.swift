import Foundation
import MasMagicPills
import XCTest

class OptionalTypeTests: XCTestCase {
    func test_wrapped_value() {
        let optional: String? = "pole"
        let another: Date? = nil

        XCTAssertEqual(optional.wrapped, optional)
        XCTAssertEqual(another.wrapped, another)
    }

    func test_filter_nil() {
        let array: [String?] = ["uno", nil, "dos", nil]

        XCTAssertEqual(array.filterNils, ["uno", "dos"])
    }

    func test_uwrapTuple_of_2_elements() {
        let tuple1 = (nil, "no") as (String?, String)
        let tuple2 = ("hola", "chau")
        let tuples = [tuple1, tuple2]

        let result = tuples.compactMap(unwrapTuple)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.0, tuple2.0)
        XCTAssertEqual(result.first?.1, tuple2.1)
    }

    func test_uwrapTuple_of_3_elements() {
        let tuple1 = (nil, "mi", "bloste") as (String?, String, String)
        let tuple2 = ("hola", "chau", "avión")
        let tuples = [tuple1, tuple2]

        let result = tuples.compactMap(unwrapTuple)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.0, tuple2.0)
        XCTAssertEqual(result.first?.1, tuple2.1)
        XCTAssertEqual(result.first?.2, tuple2.2)
    }

    func test_uwrapTuple_of_4_elements() {
        let tuple1 = (nil, "mi", "bloste", nil) as (String?, String, String, Int?)
        let tuple2 = ("hola", "chau", "avión", 5)
        let tuples = [tuple1, tuple2]

        let result = tuples.compactMap(unwrapTuple)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.0, tuple2.0)
        XCTAssertEqual(result.first?.1, tuple2.1)
        XCTAssertEqual(result.first?.2, tuple2.2)
        XCTAssertEqual(result.first?.3, tuple2.3)
    }
}
