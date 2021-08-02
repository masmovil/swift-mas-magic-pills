import Foundation
import SwiftUI
import UIKit

public struct TextStyle {
    public let font: Font
    public let color: Color
    public let lineHeight: CGFloat
    public let lineSpacing: CGFloat
    public let letterSpacing: CGFloat?
    public let textCase: Text.Case?
    public let alignment: NSTextAlignment?

    public var uiColor: UIColor {
        UIColor(color)
    }

    public var textAlignment: TextAlignment {
        switch alignment {
        case .center:
            return .center

        case .left:
            return .leading

        case .right:
            return .trailing

        default:
            return .leading
        }
    }

    public init(font: UIFont,
                color: UIColor,
                lineHeight: CGFloat,
                letterSpacing: CGFloat? = nil,
                alignment: NSTextAlignment? = nil,
                textCase: Text.Case? = nil) {
        self.uiFont = font
        self.font = Font(font)
        self.color = Color(color)
        self.lineHeight = lineHeight
        self.lineSpacing = lineHeight - font.lineHeight
        self.letterSpacing = letterSpacing
        self.alignment = alignment
        self.textCase = textCase
    }

    public init(font: Font,
                color: Color,
                lineHeight: CGFloat,
                lineSpacing: CGFloat,
                letterSpacing: CGFloat? = nil,
                alignment: NSTextAlignment? = nil,
                textCase: Text.Case? = nil) {
        self.uiFont = nil
        self.font = font
        self.color = color
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing
        self.letterSpacing = letterSpacing
        self.alignment = alignment
        self.textCase = textCase
    }

    public var uppercased: TextStyle {
        TextStyle(font: font,
                  color: color,
                  lineHeight: lineHeight,
                  lineSpacing: lineSpacing,
                  letterSpacing: letterSpacing,
                  alignment: alignment,
                  textCase: .uppercase)
    }

    // MARK: Temporal
    @available(*, deprecated, renamed: "uppercased")
    public var uppercasedStyle: TextStyle {
        uppercased
    }

    /// Don't use this whit SwiftUI.Font
    public func text(_ text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        return self.text(text)
    }

    /// Don't use this whit SwiftUI.Font
    public func text(_ text: String) -> NSAttributedString {
        text.attributed(alignment: alignment,
                        lineHeight: lineHeight,
                        letterSpacing: letterSpacing,
                        font: uiFont ?? .systemRegular(size: 15),
                        color: uiColor)
    }

    /// Don't use this whit SwiftUI.Font
    public var textAttributes: [NSAttributedString.Key: Any] {
        text(" ").attributes(at: 0, effectiveRange: nil)
    }

    private let uiFont: UIFont?
}
