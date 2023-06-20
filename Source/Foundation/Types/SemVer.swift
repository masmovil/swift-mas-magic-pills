import Foundation

/// Wrapper for version representation according to https://semver.org
public struct Semver: Comparable, CustomStringConvertible {
    /// Initialices a Semver from a string version compatible.
    /// - Parameter string: version literal
    public init(_ string: String) {
        let splittedString = string.split(separator: ".")
        for (index, component) in splittedString.enumerated() {
            components[index] = Int(component) ?? 0
        }
    }

    /// Initialices a Semver from his components
    /// - Parameter major: major componente of the version
    /// - Parameter minor: minor componente of the version
    /// - Parameter patch: patch componente of the version
    public init(major: Int, minor: Int, patch: Int) {
        components[0] = major
        components[1] = minor
        components[2] = patch
    }

    public var major: Int {
        components[0]
    }

    public var minor: Int {
        components[1]
    }

    public var patch: Int {
        components[2]
    }

    /// Version formatted with MAJOR.MINOR pattern. Example: 3.41
    public var simple: String {
        "\(major).\(minor)"
    }

    /// Version formatted with MAJOR.MINOR.PATCH pattern. Example: 3.41.2
    public var full: String {
        "\(major).\(minor).\(patch)"
    }

    /// Version formatted with MAJOR.MINOR.PATCH pattern prefixed with an v. Example: v3.41.2
    public var commercial: String {
        "v\(major).\(minor).\(patch)"
    }

    public var description: String {
        commercial
    }

    // Private

    private var components = [Int](repeating: 0, count: 3)
}

public func < (lhs: Semver, rhs: Semver) -> Bool {
    if lhs.major == rhs.major {
        if lhs.minor == rhs.minor {
            return lhs.patch < rhs.patch
        }
        return lhs.minor < rhs.minor
    }
    return lhs.major < rhs.major
}

public func == (lhs: Semver, rhs: Semver) -> Bool {
    if lhs.major == rhs.major && lhs.minor == rhs.minor {
        return lhs.patch == rhs.patch
    }
    return false
}
