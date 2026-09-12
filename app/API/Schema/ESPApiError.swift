struct ESPApiError: Decodable {
    let code: ESPApiErrorCode
    let message: String?
}
