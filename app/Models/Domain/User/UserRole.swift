enum UserRole {
    case owner
    case member
}

extension UserRole {
    init(_ data: UserRoleData) {
        switch data {
        case .owner:
            self = .owner
        case .member:
            self = .member
        }
    }
}
