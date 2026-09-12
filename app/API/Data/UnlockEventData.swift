struct UnlockEventData: Decodable {
    let id: UInt32
    let timestamp: UInt32
    let userId: UInt8
    let userName: String
    let method: UnlockMethodData
}
