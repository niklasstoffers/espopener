struct UserId: Equatable, Hashable {
    enum ValidationError: Error {
        case zero
    }

    let rawValue: UInt8

    init(_ rawValue: UInt8) throws {
        guard rawValue > 0 else {
            throw DomainValidationError.userId(.zero)
        }

        self.rawValue = rawValue
    }
}
