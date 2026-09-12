import Foundation

final class HTTPESPApiTransport: ESPApiTransport {
    private let address: URL
    private let tokenProvider: any ESPApiTokenProvider
    
    init(address: URL, tokenProvider: any ESPApiTokenProvider) {
        self.address = address
        self.tokenProvider = tokenProvider
    }

    private func makeEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    private func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
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
        case .setup(let token):
            urlRequest.setValue("Setup \(token)", forHTTPHeaderField: "Authorization")
        
        case .invite(let token):
            urlRequest.setValue("Invite \(token)", forHTTPHeaderField: "Authorization")
            
        case .bearer:
            let token: String?
            
            do {
                token = try tokenProvider.token()
            } catch {
                throw ESPApiTransportError.tokenProvider(error)
            }
            
            guard let token else {
                throw ESPApiTransportError.missingToken
            }

            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = request.body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                urlRequest.httpBody = try makeEncoder().encode(body)
            } catch {
                throw ESPApiTransportError.encode(error)
            }
        }

        return urlRequest
    }

    private func fetchResponse<Response: Decodable>(
        for urlRequest: URLRequest,
    ) async throws -> ESPApiResponse<Response> {
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw ESPApiTransportError.network(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ESPApiTransportError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw ESPApiTransportError.httpError(statusCode: httpResponse.statusCode)
        }

        do {
            return try makeDecoder().decode(ESPApiResponse<Response>.self, from: data)
        } catch {
            throw ESPApiTransportError.decode(error)
        }
    }
}
