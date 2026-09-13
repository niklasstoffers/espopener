extension ESPApiTransport {
    func sendExpectingSuccess<Request: ESPApiTransportRequest>(
        _ request: Request
    ) async throws where Request.ResponseData == EmptyResponseData {
        _ = try await internalSendExpectingSuccess(request)
    }

    func sendExpectingSuccess<Request: ESPApiTransportRequest>(
        _ request: Request
    ) async throws -> Request.ResponseData {
        let response = try await internalSendExpectingSuccess(request)

        guard let data = response.data else {
            throw ESPApiServiceError.missingResponseData
        }

        return data
    }

    func sendExpectingSuccess<Request: ESPApiTransportRequest, Model>(
        _ request: Request,
        map: (Request.ResponseData) throws -> Model
    ) async throws -> Model {
        let data = try await sendExpectingSuccess(request)

        do {
            return try map(data)
        } catch {
            throw ESPApiServiceError.malformedResponseData
        }
    }

    private func internalSendExpectingSuccess<Request: ESPApiTransportRequest>(
        _ request: Request
    ) async throws -> ESPApiResponse<Request.ResponseData> {
        let response: ESPApiResponse<Request.ResponseData>

        do {
            response = try await send(request)
        } catch {
            throw ESPApiServiceError.map(error)
        }

        guard response.result == .success else {
            guard let apiError = response.error else {
                throw ESPApiServiceError.malformedResponseData
            }
            
            throw ESPApiServiceError.api(apiError)
        }

        return response
    }
}
