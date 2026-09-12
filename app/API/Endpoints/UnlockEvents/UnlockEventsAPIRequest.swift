import Foundation

struct UnlockEventsAPIRequest: PaginatedAPIRequest {
    typealias Body = EmptyRequestData
    typealias ItemData = UnlockEventData

    let endpoint: ESPApiEndpoint = .unlockEvents
    let method: HTTPMethod = .get
    let body: EmptyRequestData? = nil
    let pagination: PaginationQuery

    init(pagination: PaginationQuery = PaginationQuery()) {
        self.pagination = pagination
    }
}