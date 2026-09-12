import Foundation

protocol PaginatedAPIRequest: ESPApiTransportRequest
where ResponseData == PaginatedResponseData<ItemData> {
    associatedtype ItemData: Decodable

    var pagination: PaginationQuery { get }
}

extension PaginatedAPIRequest {
    var queryItems: [URLQueryItem] {
        pagination.toURLQueryItems()
    }
}
