import Foundation

public extension Result {
    var isSuccess: Bool {
        successValue.isNotNil
    }

    var isFailure: Bool {
        failureError.isNotNil
    }

    var successValue: Success? {
        try? get()
    }

    var failureError: Failure? {
        switch self {
        case .failure(let error):
            return error

        case .success:
            return nil
        }
    }
}
