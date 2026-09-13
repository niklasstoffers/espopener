import Foundation

struct DeviceStatus {
    let uptime: TimeInterval
    let currentTime: Date
    let state: DeviceState
    let firmwareVersion: FirmwareVersion
    let deviceId: DeviceId
}

extension DeviceStatus {
    init(_ data: DeviceStatusData) throws {
        self.uptime = TimeInterval(data.uptimeSeconds)
        self.currentTime = Date(timeIntervalSince1970: TimeInterval(data.currentTime))
        self.state = DeviceState(data.state)
        self.firmwareVersion = try FirmwareVersion(data.firmwareVersion)
        self.deviceId = try DeviceId(data.deviceId)
    }
}
