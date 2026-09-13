enum DeviceState {
    case factoryReset
    case networkConfigured
    case claimed
}

extension DeviceState {
    init(_ data: DeviceStateData) {
        switch data {
        case .factoryReset:
            self = .factoryReset
        case .networkConfigured:
            self = .networkConfigured
        case .claimed:
            self = .claimed
        }
    }
}
