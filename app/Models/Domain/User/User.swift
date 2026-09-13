struct User {
    let userId: UserId
    let username: Username
    let role: UserRole
}

extension User {
    init(_ data: UserData) throws {
        self.userId = try UserId(data.userId)
        self.username = try Username(data.username)
        self.role = UserRole(data.role)
    }
}
