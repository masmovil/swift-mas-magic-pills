import Foundation
import SwiftUI

public extension Color {
    init(hex: String) throws {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            throw MagicError.invalidInput
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self = Color(.sRGB,
                     red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                     green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
                     blue: Double(rgbValue & 0x0000FF) / 255.0,
                     opacity: Double(1.0))
    }
}
