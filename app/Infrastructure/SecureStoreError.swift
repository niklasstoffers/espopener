import Foundation

enum SecureStoreError: Error {
    case invalidData
    case unexpectedOSStatus(OSStatus)
}
