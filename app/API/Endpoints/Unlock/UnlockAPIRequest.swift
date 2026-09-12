struct UnlockAPIRequest: ESPApiTransportRequest {
    typealias Body = UnlockRequestData
    typealias ResponseData = EmptyResponseData

    let endpoint: ESPApiEndpoint = .unlock
    let method: HTTPMethod = .post
    let body: UnlockRequestData?

    init(method: UnlockMethodData) {
        self.body = UnlockRequestData(method: method)
    }
}
