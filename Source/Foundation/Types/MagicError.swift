import Foundation

public enum MagicError: Error, Equatable {
    case badRequest
    case cantConvertToDictionary
    case cantCreateOutput
    case invalidInput
}
