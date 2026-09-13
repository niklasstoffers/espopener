protocol UserService {
    func createUser(username: Username, setupToken: SetupToken) async throws
    func createUser(username: Username, inviteToken: InviteToken) async throws
}
