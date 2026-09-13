struct WiFiPassword: Equatable, Hashable {
    enum ValidationError: Error {
        case tooShort(minimumLength: Int)
        case tooLong(maximumLength: Int)
        case invalidCharacters
    }

    static let minimumLength = 8
    static let maximumLength = 63

    private static let pattern = /^[ -~]+$/

    let rawValue: String

    init(_ rawValue: String) throws {
        guard rawValue.count >= Self.minimumLength else {
            throw DomainValidationError.wiFiPassword(
                .tooShort(minimumLength: Self.minimumLength)
            )
        }

        guard rawValue.count <= Self.maximumLength else {
            throw DomainValidationError.wiFiPassword(
                .tooLong(maximumLength: Self.maximumLength)
            )
        }

        guard rawValue.wholeMatch(of: Self.pattern) != nil else {
            throw DomainValidationError.wiFiPassword(.invalidCharacters)
        }

        self.rawValue = rawValue
    }
}
