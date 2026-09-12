struct DeleteUserAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = EmptyResponseData
    
    let endpoint: ESPApiEndpoint
    let method: HTTPMethod = .delete
    
    init(for userId: UInt8) {
        self.endpoint = .userById(userId)
    }
}
