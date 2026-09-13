enum DeviceSetupError: Error {
    case deviceAlreadyClaimed
    case unexpectedDeviceState(DeviceState)
}
