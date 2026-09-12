enum DeviceStateData: String, Decodable {
    case factoryReset = "factory_reset"
    case networkConfigured = "network_configured"
    case claimed
}
