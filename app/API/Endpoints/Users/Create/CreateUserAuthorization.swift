enum CreateUserAuthorization {
    case setup(token: String)
    case invite(token: String)
    
    func toESPApiAuthorizationMethod() -> ESPApiAuthorization {
        switch self {
        case .setup(let token):
            ESPApiAuthorization.setup(token: token)
        case .invite(let token):
            ESPApiAuthorization.invite(token: token)
        }
    }
}
