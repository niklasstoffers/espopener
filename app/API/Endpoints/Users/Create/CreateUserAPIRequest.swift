struct CreateUserAPIRequest: ESPApiTransportRequest {
    typealias Body = CreateUserRequestData
    typealias ResponseData = CreateUserResponseData

    let endpoint: ESPApiEndpoint = .users
    let method: HTTPMethod = .post
    let body: CreateUserRequestData?
    let authorization: ESPApiAuthorization

    init(username: String, authorization: CreateUserAuthorization) {
        self.body = CreateUserRequestData(username: username)
        self.authorization = authorization.toESPApiAuthorizationMethod()
    }
}
