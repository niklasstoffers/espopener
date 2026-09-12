struct CurrentUserAPIRequest: ESPApiTransportRequest {
    typealias Body = EmptyRequestData
    typealias ResponseData = UserData

    let endpoint: ESPApiEndpoint = .currentUser
}
