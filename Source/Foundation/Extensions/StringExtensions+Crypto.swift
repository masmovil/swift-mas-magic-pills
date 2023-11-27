import CommonCrypto
import Foundation

public extension String {
    enum HMACDigest {
        case sha256(secret: String)
    }

    /// This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).
    var md5: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        data.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &hash)
        }

        return hash.map { String(format: "%02x", $0) }.joined().uppercased()
    }

    /// This function is cryptographically broken and should not be used in security contexts.
    var sha1: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))

        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &hash)
        }

        return hash.map { String(format: "%02x", $0) }.joined().uppercased()
    }

    var sha256: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))

        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }

        return hash.map { String(format: "%02x", $0) }.joined().uppercased()
    }

    var sha512: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))

        data.withUnsafeBytes {
            _ = CC_SHA512($0.baseAddress, CC_LONG(data.count), &hash)
        }

        return hash.map { String(format: "%02x", $0) }.joined().uppercased()
    }

    func hmac(_ digest: HMACDigest) -> String {
        switch digest {
        case .sha256(let secret):
            let commonCryptoAlgorithm = CCHmacAlgorithm(kCCHmacAlgSHA256)
            let commonCryptoDigestLength = CC_SHA256_DIGEST_LENGTH

            let message = self.dataUTF8
            let key = secret.dataUTF8
            let context = UnsafeMutablePointer<CCHmacContext>.allocate(capacity: 1)
            defer { context.deallocate() }

            key.withUnsafeBytes { (buffer: UnsafePointer<UInt8>) in
              CCHmacInit(context, commonCryptoAlgorithm, buffer, size_t(key.count))
            }

            message.withUnsafeBytes { (buffer: UnsafePointer<UInt8>) in
              CCHmacUpdate(context, buffer, size_t(message.count))
            }

            var hmac = [UInt8](repeating: 0, count: Int(commonCryptoDigestLength))
            CCHmacFinal(context, &hmac)
            let hmacData = Data(hmac).base64EncodedData()
            return String(data: hmacData, encoding: .utf8)!
        }
    }
}
