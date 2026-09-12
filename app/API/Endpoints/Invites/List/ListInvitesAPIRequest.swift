struct ListInvitesAPIRequest: PaginatedAPIRequest {
    typealias Body = EmptyRequestData
    typealias ItemData = InviteData
    
    let endpoint: ESPApiEndpoint = .invites
    let pagination: PaginationQuery
    
    init(pagination: PaginationQuery = PaginationQuery()) {
        self.pagination = pagination
    }
}
