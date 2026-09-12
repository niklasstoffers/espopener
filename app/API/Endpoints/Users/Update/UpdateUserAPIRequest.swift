struct UpdateUserAPIRequest: ESPApiTransportRequest {
    typealias Body = UpdateUserRequestData
    typealias ResponseData = EmptyResponseData
    
    let endpoint: ESPApiEndpoint
    let method: HTTPMethod = .patch
    let body: UpdateUserRequestData?
    
    init(for userId: UInt8, username: String, role: UserRoleData) {
        self.endpoint = .userById(userId)
        self.body = UpdateUserRequestData(username: username, role: role)
    }
}
