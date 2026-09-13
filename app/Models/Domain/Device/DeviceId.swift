import Foundation

struct DeviceId: Equatable, Hashable {
    enum ValidationError: Error {
        case invalidFormat
    }

    let rawValue: UUID

    init(_ rawValue: String) throws {
        guard let uuid = UUID(uuidString: rawValue) else {
            throw DomainValidationError.deviceId(.invalidFormat)
        }

        self.rawValue = uuid
    }
}
