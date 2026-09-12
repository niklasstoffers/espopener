struct CreateInviteAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = CreateInviteResponseData
    
    let endpoint: ESPApiEndpoint = .invites
    let method: HTTPMethod = .post
}
