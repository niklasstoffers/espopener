import Foundation

private let apiBasePath = "api/v1"

enum ESPApiEndpoint: String {
    case status
    case unlock
    case unlockEvents = "unlock_events"
    case ringEvents = "ring_events"
    
    func toUrl(relativeTo address: URL) -> URL {
        address.appending(path: apiBasePath).appending(path: rawValue)
    }
}
