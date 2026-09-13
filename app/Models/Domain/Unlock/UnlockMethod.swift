enum UnlockMethod {
    case automatic
    case manual
}

extension UnlockMethod {
    init(_ data: UnlockMethodData) {
        switch data {
        case .automatic:
            self = .automatic
        case .manual:
            self = .manual
        }
    }

    var data: UnlockMethodData {
        switch self {
        case .automatic:
            return .automatic
        case .manual:
            return .manual
        }
    }
}
