struct RingEventsAPIRequest: PaginatedAPIRequest {
    typealias Body = EmptyRequestData
    typealias ItemData = RingEventData

    let endpoint: ESPApiEndpoint = .ringEvents
    let pagination: PaginationQuery

    init(pagination: PaginationQuery = PaginationQuery()) {
        self.pagination = pagination
    }
}
