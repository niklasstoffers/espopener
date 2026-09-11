struct PaginatedResponse<Item: Decodable>: Decodable {
    let items: [Item]
    let nextCursor: String?
}
