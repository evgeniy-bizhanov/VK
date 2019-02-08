import Alamofire

/**
 Предоставляет реализацию сетевого запроса по умолчанию
 */
protocol AbstractRequestManager {
    
    typealias Completion<T: Decodable> = (DataResponse<T>) -> Void
    
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    
    @discardableResult
    func request<T>(request: URLRequestConvertible, completion: @escaping Completion<T>) -> DataRequest
    
    init(sessionManager: SessionManager, queue: DispatchQueue?)
}

extension AbstractRequestManager {
    
    @discardableResult public func request<T>(
        request: URLRequestConvertible,
        completion: @escaping Completion<T>) -> DataRequest {
        
        return sessionManager
            .request(request)
            .responseCodable(
                queue: queue,
                completion: completion
        )
    }
}
