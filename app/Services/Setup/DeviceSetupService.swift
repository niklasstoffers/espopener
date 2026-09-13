final class DeviceSetupService {
    private let transport: any ESPApiTransport
    private let tokenStore: any SecureStore
    
    init(transport: any ESPApiTransport, tokenStore: any SecureStore) {
        self.transport = transport
        self.tokenStore = tokenStore
    }

    func checkDevice(setupToken: SetupToken) async throws -> DeviceStatus {
        let request = StatusAPIRequest(authorization: .setup(token: setupToken.rawValue))
        let deviceStatus = try await transport.sendExpectingSuccess(request, map: DeviceStatus.init)
        
        switch deviceStatus.state {
        case .networkConfigured:
            return deviceStatus
            
        case .claimed:
            throw DeviceSetupError.deviceAlreadyClaimed
            
        default:
            throw DeviceSetupError.unexpectedDeviceState(deviceStatus.state)
        }
    }
}
