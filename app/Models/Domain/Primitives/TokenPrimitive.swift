protocol TokenPrimitive: Equatable, Hashable {
    var rawValue: String { get }

    init(validated rawValue: String)
}

enum TokenValidationError: Error {
    case invalidFormat
}

extension TokenPrimitive {
    init(_ rawValue: String) throws {
        guard rawValue.wholeMatch(of: /^[A-Za-z0-9_-]{43}$/) != nil else {
            throw DomainValidationError.token(.invalidFormat)
        }

        self.init(validated: rawValue)
    }
}
