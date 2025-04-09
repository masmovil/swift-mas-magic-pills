import Foundation

class FakeBundle: Bundle, @unchecked Sendable {
    var versionNumberValue: String?
    var buildNumberValue: String?
    var testflight = false

    override var appStoreReceiptURL: URL? {
        guard testflight else {
            return nil
        }

        return "https://appstore.com/blabllablalab/sandboxReceipt".urlValue
    }

    override func object(forInfoDictionaryKey key: String) -> Any? {
        switch key {
        case "CFBundleShortVersionString":
            return versionNumberValue

        case "CFBundleVersion":
            return buildNumberValue

        default:
            return nil
        }
    }
}
