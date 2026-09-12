import Foundation

private let apiBasePath = "api/v1"

enum ESPApiEndpoint {
    case status
    case factoryReset
    case unlock
    case users
    case currentUser
    case userById(UInt8)
    case invites
    case inviteById(UInt8)
    case unlockEvents
    case ringEvents
    
    func toUrl(relativeTo address: URL) -> URL {
        pathComponents.reduce(address.appending(path: apiBasePath)) { url, pathComponent in
            url.appending(path: pathComponent)
        }
    }

    private var pathComponents: [String] {
        switch self {
        case .status:
            ["status"]
        case .factoryReset:
            ["factory_reset"]
        case .unlock:
            ["unlock"]
        case .users:
            ["users"]
        case .currentUser:
            ["users", "me"]
        case .userById(let id):
            ["users", String(id)]
        case .invites:
            ["invites"]
        case .inviteById(let id):
            ["invites", String(id)]
        case .unlockEvents:
            ["unlock_events"]
        case .ringEvents:
            ["ring_events"]
        }
    }
}
