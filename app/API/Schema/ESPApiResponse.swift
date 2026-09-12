struct ESPApiResponse<ResponseData: Decodable>: Decodable {
    let result: ESPApiResponseResult
    let error: ESPApiError?
    let data: ResponseData?
}
