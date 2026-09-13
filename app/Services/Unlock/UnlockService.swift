protocol UnlockService {
    func unlock(method: UnlockMethod) async throws
}