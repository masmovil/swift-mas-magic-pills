import Foundation

public extension Bundle {
    /// The release version of the bundle in Semver format
    var versionNumber: Semver {
        Semver((object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "0")
    }

    /// The build version of the bundle.
    var buildNumber: String {
        (object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String) ?? "0"
    }

    /// Release number with version number or version number if are the same
    var fullVersionNumber: String {
        versionNumber.full == buildNumber ?
            "\(versionNumber.commercial)" :
            "\(versionNumber.commercial) (\(buildNumber))"
    }

    var isRunningFromTestFlight: Bool {
        appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    }
}
