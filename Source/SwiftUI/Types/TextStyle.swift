import Foundation
import SwiftUI
#if !os(macOS) && !os(watchOS)
import UIKit
#endif

public struct TextStyle {
    public let font: Font
    public let color: Color
    public let lineHeight: CGFloat
    public let lineSpacing: CGFloat
    public let letterSpacing: CGFloat?
    public let textCase: Text.Case?
    public let alignment: NSTextAlignment?

    public var textAlignment: TextAlignment {
        switch alignment {
        case .center:
            return .center

        case .right:
            return .trailing

        default:
            return .leading
        }
    }

    public init(font: Font,
                color: Color,
                lineHeight: CGFloat,
                lineSpacing: CGFloat,
                letterSpacing: CGFloat? = nil,
                alignment: NSTextAlignment? = nil,
                textCase: Text.Case? = nil) {
        #if !os(macOS) && !os(watchOS)
        self.uiFont = nil
        #endif
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

    // MARK: REMOVE WHEN DROP SUPPORT FOR UIKit in TextStyle
    #if !os(macOS) && !os(watchOS)

    public init(uiFont: UIFont,
                uiColor: UIColor,
                lineHeight: CGFloat,
                letterSpacing: CGFloat? = nil,
                alignment: NSTextAlignment? = nil,
                textCase: Text.Case? = nil) {
        self.uiFont = uiFont
        self.font = Font(uiFont)
        self.color = Color(uiColor)
        self.lineHeight = lineHeight
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.letterSpacing = letterSpacing
        self.alignment = alignment
        self.textCase = textCase
    }

    public init(uiFont: UIFont,
                color: Color,
                lineHeight: CGFloat,
                letterSpacing: CGFloat? = nil,
                alignment: NSTextAlignment? = nil,
                textCase: Text.Case? = nil) {
        self.uiFont = uiFont
        self.font = Font(uiFont)
        self.color = color
        self.lineHeight = lineHeight
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.letterSpacing = letterSpacing
        self.alignment = alignment
        self.textCase = textCase
    }

    public var uiColor: UIColor {
        UIColor(color)
    }

    /// Don't use this whit SwiftUI.Font
    public func text(_ text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        return self.text(text)
    }

    /// Don't use this whit SwiftUI.Font
    public func text(_ text: String) -> NSAttributedString {
        guard let uiFont = uiFont else {
            fatalError("Don't use this method with SwiftUI")
        }
        return text.attributed(alignment: alignment,
                               lineHeight: lineHeight,
                               letterSpacing: letterSpacing,
                               font: uiFont,
                               color: uiColor)
    }

    /// Don't use this whit SwiftUI.Font
    public var textAttributes: [NSAttributedString.Key: Any] {
        text(" ").attributes(at: 0, effectiveRange: nil)
    }

    public let uiFont: UIFont?
    #endif
}
