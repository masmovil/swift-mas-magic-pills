import SwiftUI

public extension Text {
    func textStyle(_ textStyle: TextStyle, lineLimit: Int? = nil) -> some View {
        self.tracking(textStyle.letterSpacing ?? 0)
            .modifier(TextWithStyle(textStyle))
    }
}

private struct TextWithStyle: ViewModifier {
    private var textStyle: TextStyle
    private var lineLimit: Int?

    public init(_ textStyle: TextStyle, lineLimit: Int? = nil) {
        self.textStyle = textStyle
        self.lineLimit = lineLimit
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .font(textStyle.font)
                .foregroundColor(textStyle.color)
                .textCase(textStyle.textCase)
                .lineSpacing(textStyle.lineSpacing)
                .lineLimit(lineLimit)
                .multilineTextAlignment(textStyle.textAlignment)
        }
    }
}
