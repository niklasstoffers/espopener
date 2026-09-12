protocol ESPApiTransport {
    func send<Request: ESPApiTransportRequest>(
        _ request: Request
    ) async throws -> ESPApiResponse<Request.ResponseData>
}
