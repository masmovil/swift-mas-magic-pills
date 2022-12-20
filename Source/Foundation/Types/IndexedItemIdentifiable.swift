import Foundation

public struct IndexedItemIdentifiable<Index: Hashable, Element: Identifiable>: Identifiable, Equatable, Hashable {
    public let index: Index
    public let item: Element

    public init(index: Index, item: Element) {
        self.index = index
        self.item = item
    }

    public var id: Element.ID {
        item.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: IndexedItemIdentifiable<Index, Element>, rhs: IndexedItemIdentifiable<Index, Element>) -> Bool {
        lhs.id == rhs.id
    }
}
