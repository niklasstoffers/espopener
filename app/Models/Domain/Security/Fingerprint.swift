struct Fingerprint: Equatable, Hashable {
    enum ValidationError: Error {
        case invalidFormat
    }

    private static let pattern = /^[A-Fa-f0-9]{64}$/

    let rawValue: String

    init(_ rawValue: String) throws {
        guard rawValue.wholeMatch(of: Self.pattern) != nil else {
            throw DomainValidationError.fingerprint(.invalidFormat)
        }

        self.rawValue = rawValue.uppercased()
    }
}
