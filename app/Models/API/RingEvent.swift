struct RingEvent: Decodable {
    let id: UInt32
    let timestamp: UInt32
    let location: RingLocation
}
