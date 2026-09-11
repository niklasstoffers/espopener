enum ESPApiError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
    case encode(Error)
    case decode(Error)
}
