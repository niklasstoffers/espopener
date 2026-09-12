struct SecureStoreESPApiTokenProvider: ESPApiTokenProvider {
    private let secureStore: any SecureStore
    
    init(secureStore: any SecureStore) {
        self.secureStore = secureStore
    }
    
    func token() throws -> String? {
        try secureStore.get(for: SecureStoreKey.espApiToken)
    }
}
