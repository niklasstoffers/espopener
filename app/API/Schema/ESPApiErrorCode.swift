struct ESPApiErrorCode: RawRepresentable, Decodable, Equatable, Hashable {
    let rawValue: String

    static let generic = Self(rawValue: "generic")
}
