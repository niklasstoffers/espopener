final class ESPUnlockService: UnlockService {
    private let transport: any ESPApiTransport

    init(transport: any ESPApiTransport) {
        self.transport = transport
    }
    
    func unlock(method: UnlockMethod) async throws {
        let request = UnlockAPIRequest(method: method.data)
        try await transport.sendExpectingSuccess(request)
    }
}
