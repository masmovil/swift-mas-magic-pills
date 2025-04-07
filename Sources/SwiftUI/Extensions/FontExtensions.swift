import Foundation
import SwiftUI
#if !os(macOS) && !os(watchOS)
import UIKit
#endif

public extension Font {
    static func existsCustomFont(_ name: String) -> Bool? {
        #if !os(macOS) && !os(watchOS)
        guard let _ = UIFont(name: name, size: 12) else {
            return false
        }
        return true
        #else
        return nil
        #endif
    }
}
