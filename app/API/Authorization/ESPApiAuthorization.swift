enum ESPApiAuthorization {
    case bearer
    case setup(token: String)
    case invite(token: String)
}
