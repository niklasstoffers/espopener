import Foundation

struct UnlockAPIRequest: ESPApiTransportRequest {
    typealias Body = UnlockRequestData
    typealias ResponseData = EmptyResponseData

    let endpoint: ESPApiEndpoint = .unlock
    let method: HTTPMethod = .post
    let body: UnlockRequestData?
    let queryItems: [URLQueryItem] = []

    init(method: UnlockMethodData) {
        self.body = UnlockRequestData(method: method)
    }
}
