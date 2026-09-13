import Foundation

protocol BluetoothProvisioningService {
    func discoverDevices() -> AsyncThrowingStream<[BluetoothProvisioningDevice], Error>
    func connect(to device: BluetoothProvisioningDevice) async throws
    func authenticate(setupCode: String) async throws
    func configureWiFi(credentials: WiFiCredentials) async throws -> BluetoothProvisioningResult
    func disconnect()
}
