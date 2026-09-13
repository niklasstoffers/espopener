struct FirmwareVersion: Equatable, Hashable {
    enum ValidationError: Error {
        case invalidFormat
    }

    private static let pattern = /^(\d+\.){2}\d+$/

    let rawValue: String

    init(_ rawValue: String) throws {
        guard rawValue.wholeMatch(of: Self.pattern) != nil else {
            throw DomainValidationError.firmwareVersion(.invalidFormat)
        }

        self.rawValue = rawValue
    }
}
