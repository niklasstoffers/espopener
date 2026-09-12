struct DeviceStatusData: Decodable {
    let uptimeSeconds: UInt32
    let currentTime: UInt32
    let state: DeviceStateData
    let firmwareVersion: String
    let deviceId: String
}
