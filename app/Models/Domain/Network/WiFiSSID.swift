struct WiFiSSID: Equatable, Hashable {
    enum ValidationError: Error {
        case empty
        case tooLong(maximumByteLength: Int)
    }

    static let maximumByteLength = 32

    let rawValue: String

    init(_ rawValue: String) throws {
        guard !rawValue.isEmpty else {
            throw DomainValidationError.wiFiSSID(.empty)
        }

        guard rawValue.utf8.count <= Self.maximumByteLength else {
            throw DomainValidationError.wiFiSSID(
                .tooLong(maximumByteLength: Self.maximumByteLength)
            )
        }

        self.rawValue = rawValue
    }
}
