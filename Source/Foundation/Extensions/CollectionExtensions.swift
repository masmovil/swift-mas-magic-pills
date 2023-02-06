import Foundation

public extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }

    /// Returns a copy as an array with the indices of each element.
    func enumeratedArray() -> [IndexedItem<Indices.Iterator.Element, Iterator.Element>] {
        Array(zip(indices, self)).map { index, value in
            IndexedItem(index: index, value: value)
        }
    }

    /// Returns a copy as an array with the indices of each `Identifiable` element.
    func enumeratedArray() -> [IndexedItemIdentifiable<Indices.Iterator.Element, Iterator.Element>] where Iterator.Element: Identifiable {
        Array(zip(indices, self)).map { index, value in
            IndexedItemIdentifiable(index: index, value: value)
        }
    }
}
