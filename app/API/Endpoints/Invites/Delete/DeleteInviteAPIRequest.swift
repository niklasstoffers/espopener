struct DeleteInviteAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = EmptyResponseData
    
    let endpoint: ESPApiEndpoint
    let method: HTTPMethod = .delete
    
    init(for inviteId: UInt8) {
        self.endpoint = .inviteById(inviteId)
    }
}
