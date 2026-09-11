import Foundation

final class ESPApiClient {
    private let token: String
    private let address: URL
    
    init(token: String, address: URL) {
        self.token = token
        self.address = address
    }
    
    func unlock(method: UnlockMethod) async throws {
        let _: EmptyResponse = try await sendRequest(
            to: .unlock,
            body: UnlockRequest(method: method)
        )
    }

    func fetchStatus() async throws {
        let _: EmptyResponse = try await sendRequest(to: .status)
    }
    
    func fetchUnlockEvents(
        limit: UInt = 20,
        cursor: String? = nil
    ) async throws -> PaginatedResponse<UnlockEvent> {
        try await fetchPaginated(
            to: .unlockEvents,
            limit: limit,
            cursor: cursor
        )
    }
    
    func fetchRingEvents(
        limit: UInt = 20,
        cursor: String? = nil
    ) async throws -> PaginatedResponse<RingEvent> {
        try await fetchPaginated(
            to: .ringEvents,
            limit: limit,
            cursor: cursor
        )
    }
    
    private func fetchPaginated<Item: Decodable>(
        to endpoint: ESPApiEndpoint,
        limit: UInt,
        cursor: String?
    ) async throws -> PaginatedResponse<Item> {
        var queryItems = [URLQueryItem(name: "limit", value: String(limit))]
        if let cursor {
            queryItems.append(URLQueryItem(name: "cursor", value: cursor))
        }
        
        return try await sendRequest(
            to: endpoint,
            queryItems: queryItems
        )
    }

    private func sendRequest<Response: Decodable>(
        to endpoint: ESPApiEndpoint,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        responseType: Response.Type = Response.self
    ) async throws -> Response {
        try await sendRequest(
            to: endpoint,
            method: method,
            body: Optional<EmptyRequest>.none,
            queryItems: queryItems,
            responseType: responseType
        )
    }

    private func sendRequest<Body: Encodable, Response: Decodable>(
        to endpoint: ESPApiEndpoint,
        method: HTTPMethod = .post,
        body: Body?,
        queryItems: [URLQueryItem] = [],
        responseType: Response.Type = Response.self
    ) async throws -> Response {
        let request = try buildRequest(
            to: endpoint,
            method: method,
            body: body,
            queryItems: queryItems
        )
        
        return try await fetchResponse(for: request)
    }

    private func buildRequest<Body: Encodable>(
        to endpoint: ESPApiEndpoint,
        method: HTTPMethod,
        body: Body?,
        queryItems: [URLQueryItem]
    ) throws -> URLRequest {
        var url = endpoint.toUrl(relativeTo: address)
        url.append(queryItems: queryItems)

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        if let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw ESPApiError.encode(error)
            }
        }

        return request
    }

    private func fetchResponse<Response: Decodable>(
        for urlRequest: URLRequest,
        responseType: Response.Type = Response.self
    ) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ESPApiError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw ESPApiError.httpError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw ESPApiError.decode(error)
        }
    }
}
