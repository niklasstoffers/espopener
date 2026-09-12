protocol SecureStore {
    func get(for key: String) throws -> String?
    func set(_ value: String, for key: String) throws
    func delete(for key: String) throws
}
