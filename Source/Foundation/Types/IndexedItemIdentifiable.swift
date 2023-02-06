import Foundation

public struct IndexedItemIdentifiable<Index: Comparable, Element: Identifiable>: Identifiable, Equatable, Hashable {
    public let index: Index
    public let value: Element

    @available(*, deprecated, renamed: "value")
    public var item: Element {
        value
    }

    public init(index: Index, value: Element) {
        self.index = index
        self.value = value
    }

    public var id: Element.ID {
        value.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: IndexedItemIdentifiable<Index, Element>, rhs: IndexedItemIdentifiable<Index, Element>) -> Bool {
        lhs.id == rhs.id
    }
}
