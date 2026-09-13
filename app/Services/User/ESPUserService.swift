final class ESPUserService: UserService {
    private let transport: any ESPApiTransport
    private let secureStore: any SecureStore

    init(transport: any ESPApiTransport, secureStore: any SecureStore) {
        self.transport = transport
        self.secureStore = secureStore
    }

    func createUser(username: Username, setupToken: SetupToken) async throws {
        try await createUser(username: username, authorization: .setup(token: setupToken.rawValue))
    }
    
    func createUser(username: Username, inviteToken: InviteToken) async throws {
        try await createUser(username: username, authorization: .invite(token: inviteToken.rawValue))
    }
    
    private func createUser(username: Username, authorization: CreateUserAuthorization) async throws {
        let request = CreateUserAPIRequest(username: username.rawValue, authorization: authorization)
        let createUserResult = try await transport.sendExpectingSuccess(request, map: CreateUserResult.init)
        
        do {
            try self.secureStore.set(createUserResult.token.rawValue, for: SecureStoreKey.espApiToken)
        } catch {
            throw CreateUserError.tokenStorageFailed(error)
        }
    }
}
