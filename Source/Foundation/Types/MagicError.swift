import Foundation

public enum MagicError: Error {
    case badRequest
    case cantConvertToDictionary
    case cantCreateOutput
    case invalidInput
}
