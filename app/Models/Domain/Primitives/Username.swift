struct Username: Equatable, Hashable {
    enum ValidationError: Error {
        case tooShort(minimumLength: Int)
        case tooLong(maximumLength: Int)
        case invalidCharacters
    }

    static let minimumLength = 4
    static let maximumLength = 32

    private static let pattern = /^[A-Za-z0-9._]+$/

    let rawValue: String

    init(_ rawValue: String) throws {
        guard rawValue.count >= Self.minimumLength else {
            throw DomainValidationError.username(.tooShort(minimumLength: Self.minimumLength))
        }

        guard rawValue.count <= Self.maximumLength else {
            throw DomainValidationError.username(.tooLong(maximumLength: Self.maximumLength))
        }

        guard rawValue.wholeMatch(of: Self.pattern) != nil else {
            throw DomainValidationError.username(.invalidCharacters)
        }

        self.rawValue = rawValue
    }
}
