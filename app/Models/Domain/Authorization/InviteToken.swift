struct InviteToken: TokenPrimitive {
    let rawValue: String

    init(validated rawValue: String) {
        self.rawValue = rawValue
    }
}
