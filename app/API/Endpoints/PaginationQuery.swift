import Foundation

struct PaginationQuery {
    static let defaultLimit: UInt = 20

    let limit: UInt
    let cursor: String?

    init(limit: UInt = defaultLimit, cursor: String? = nil) {
        self.limit = limit
        self.cursor = cursor
    }

    func toURLQueryItems() -> [URLQueryItem] {
        var items = [URLQueryItem(name: "limit", value: String(limit))]

        if let cursor {
            items.append(URLQueryItem(name: "cursor", value: cursor))
        }

        return items
    }
}