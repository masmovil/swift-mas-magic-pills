import Foundation

public extension Bundle {
    /// The release ("Major"."Minor"."Patch") or version number of the bundle
    var versionNumber: String {
        (object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "0"
    }

    @available(*, deprecated, renamed: "versionNumber")
    var appVersion: String {
        versionNumber
    }

    /// The version number of the bundle. (read-only, optional)
    var buildNumber: String {
        (object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String) ?? "0"
    }

    @available(*, deprecated, renamed: "buildNumber")
    var appBuild: String {
        buildNumber
    }

    /// Release number with version number or version number if are the same (read-only, optional)
    var fullVersionNumber: String {
        versionNumber == buildNumber ? "v\(versionNumber)" : "v\(versionNumber)(\(buildNumber))"
    }

    @available(*, deprecated, renamed: "fullVersionNumber")
    var appFullVersion: String {
        fullVersionNumber
    }

    var isRunningFromTestFlight: Bool {
        appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    }

    @available(*, deprecated, renamed: "isRunningFromTestFlight")
    var runningFromTestFlight: Bool {
        isRunningFromTestFlight
    }
}
