import SwiftUI

public extension Text {
    func textStyle(_ textStyle: TextStyle) -> some View {
        self.tracking(textStyle.letterSpacing ?? 0)
            .modifier(TextWithStyle(textStyle))
    }
}

private struct TextWithStyle: ViewModifier {
    private var textStyle: TextStyle

    public init(_ textStyle: TextStyle) {
        self.textStyle = textStyle
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .font(textStyle.font)
                .foregroundColor(textStyle.color)
                .textCase(textStyle.textCase)
                .lineSpacing(textStyle.lineSpacing)
                .lineLimit(nil)
                .multilineTextAlignment(textStyle.textAlignment)
        }
    }
}
