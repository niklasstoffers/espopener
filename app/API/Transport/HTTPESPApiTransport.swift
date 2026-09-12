import Foundation

final class HTTPESPApiTransport: ESPApiTransport {
    private let address: URL
    private let tokenProvider: any ESPApiTokenProvider
    
    init(address: URL, tokenProvider: any ESPApiTokenProvider) {
        self.address = address
        self.tokenProvider = tokenProvider
    }

    func send<Request: ESPApiTransportRequest>(
        _ request: Request
    ) async throws -> ESPApiResponse<Request.ResponseData> {
        let urlRequest = try buildURLRequest(request)
        return try await fetchResponse(for: urlRequest)
    }

    private func buildURLRequest<Request: ESPApiTransportRequest>(
        _ request: Request
    ) throws -> URLRequest {
        var url = request.endpoint.toUrl(relativeTo: address)
        url.append(queryItems: request.queryItems)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        switch request.authorization {
        case .none:
            break
            
        case .bearer:
            guard let token = try tokenProvider.token() else {
                throw ESPApiTransportError.missingToken
            }

            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = request.body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw ESPApiTransportError.encode(error)
            }
        }

        return urlRequest
    }

    private func fetchResponse<Response: Decodable>(
        for urlRequest: URLRequest,
    ) async throws -> ESPApiResponse<Response> {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ESPApiTransportError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw ESPApiTransportError.httpError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(ESPApiResponse<Response>.self, from: data)
        } catch {
            throw ESPApiTransportError.decode(error)
        }
    }
}
