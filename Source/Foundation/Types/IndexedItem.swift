import Foundation

public struct IndexedItem<Index: Comparable, Element> {
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
}
