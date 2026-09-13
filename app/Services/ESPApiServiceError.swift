enum ESPApiServiceError: Error {
    case deviceNotReachable
    case unauthorized
    case internalServerError
    case forbidden
    case notFound
    case missingResponseData
    case malformedResponseData
    case validation(DomainValidationError)
    case api(ESPApiError)
    case transport(ESPApiTransportError)
    case unknown(Error)
}

extension ESPApiServiceError {
    static func map(_ error: Error) -> ESPApiServiceError {
        if let error = error as? ESPApiTransportError {
            switch error {
            case .network:
                return .deviceNotReachable
                
            case .httpError(let statusCode):
                switch statusCode {
                case 401:
                    return .unauthorized
                case 403:
                    return .forbidden
                case 404:
                    return .notFound
                case 500...599:
                    return .internalServerError
                default:
                    return .transport(error)
                }
                
            default:
                return .transport(error)
            }
        }
        
        return .unknown(error)
    }
}
