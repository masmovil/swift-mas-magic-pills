import Foundation

public extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }

    /// Returns a copy as an array with the indices of each element.
    func enumeratedArray() -> [(index: Indices.Iterator.Element, item: Iterator.Element)] {
        Array(zip(indices, self))
    }

    /// Returns a copy as an array with the indices of each `Identifiable` element.
    func enumeratedArray() -> [IndexedItemIdentifiable<Indices.Iterator.Element, Iterator.Element>] where Iterator.Element: Identifiable {
        Array(zip(indices, self)).map { index, item in
            IndexedItemIdentifiable(index: index, item: item)
        }
    }
}
