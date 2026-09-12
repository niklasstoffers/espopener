enum ESPApiTransportError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
    case encode(Error)
    case decode(Error)
    case missingToken
    case tokenProvider(Error)
    case network(Error)
}
