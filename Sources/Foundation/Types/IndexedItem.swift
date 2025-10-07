import Foundation

public struct IndexedItem<Index: Hashable, Element>: Identifiable, Equatable, Hashable {
    public let index: Index
    public let value: Element

    @available(*, deprecated, renamed: "value")
    public var item: Element {
        value
    }

    public var id: Index {
        index
    }

    public init(index: Index, value: Element) {
        self.index = index
        self.value = value
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: IndexedItem<Index, Element>, rhs: IndexedItem<Index, Element>) -> Bool {
        lhs.id == rhs.id
    }
}
