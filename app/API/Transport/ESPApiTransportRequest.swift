import Foundation

protocol ESPApiTransportRequest {
    associatedtype Body: Encodable
    associatedtype ResponseData: Decodable

    var endpoint: ESPApiEndpoint { get }
    var method: HTTPMethod { get }
    var body: Body? { get }
    var queryItems: [URLQueryItem] { get }
    var authorization: ESPApiAuthorization { get }
}

extension ESPApiTransportRequest {
    var authorization: ESPApiAuthorization {
        .bearer
    }
}
