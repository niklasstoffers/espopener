struct ListUsersAPIRequest: PaginatedAPIRequest {
    typealias Body = EmptyRequestData
    typealias ItemData = UserData

    let endpoint: ESPApiEndpoint = .users
    let pagination: PaginationQuery

    init(pagination: PaginationQuery = PaginationQuery()) {
        self.pagination = pagination
    }
}
