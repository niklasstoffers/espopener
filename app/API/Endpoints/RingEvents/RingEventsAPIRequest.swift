import Foundation

struct RingEventsAPIRequest: PaginatedAPIRequest {
    typealias Body = EmptyRequestData
    typealias ItemData = RingEventData

    let endpoint: ESPApiEndpoint = .ringEvents
    let method: HTTPMethod = .get
    let body: EmptyRequestData? = nil
    let pagination: PaginationQuery

    init(pagination: PaginationQuery = PaginationQuery()) {
        self.pagination = pagination
    }
}
