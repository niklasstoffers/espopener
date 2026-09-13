protocol DeviceSetupService {
    func checkDevice(setupToken: SetupToken) async throws -> DeviceStatus
}
