enum DomainValidationError: Error {
    case userId(UserId.ValidationError)
    case username(Username.ValidationError)
    case firmwareVersion(FirmwareVersion.ValidationError)
    case deviceId(DeviceId.ValidationError)
    case token(TokenValidationError)
}
