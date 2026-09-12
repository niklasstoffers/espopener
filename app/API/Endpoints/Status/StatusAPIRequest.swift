struct StatusAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = DeviceStatusData

    let endpoint: ESPApiEndpoint = .status
    let authorization: ESPApiAuthorization
    
    init(authorization: ESPApiAuthorization = .bearer) {
        self.authorization = authorization
    }
}
