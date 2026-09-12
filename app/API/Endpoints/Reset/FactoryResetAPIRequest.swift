struct FactoryResetAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = EmptyResponseData
    
    let endpoint: ESPApiEndpoint = .factoryReset
    let method: HTTPMethod = .post
}
