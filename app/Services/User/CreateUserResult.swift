struct CreateUserResult {
    let token: AccessToken
}

extension CreateUserResult {
    init(_ data: CreateUserResponseData) throws {
        self.token = try AccessToken(data.token)
    }
}
