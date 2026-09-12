struct PaginatedResponseData<Item: Decodable>: Decodable {
    let items: [Item]
    let nextCursor: String?
}
