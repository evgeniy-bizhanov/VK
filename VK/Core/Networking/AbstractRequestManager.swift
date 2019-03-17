import Alamofire

/**
 Предоставляет реализацию сетевого запроса по умолчанию
 */
protocol AbstractRequestManager {
    
    typealias Completion<T: Decodable> = (T) -> Void
    
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    
    var url: URL! { get }
    var token: String? { get }
    
    @discardableResult
    func request<T>(request: URLRequestConvertible, completion: Completion<T>?) -> DataRequest
    
    init(sessionManager: SessionManager, queue: DispatchQueue?, keychainStorage: KeyValueStorage?)
}

extension AbstractRequestManager {
    
    @discardableResult public func request<T>(
        request: URLRequestConvertible,
        completion: Completion<T>?) -> DataRequest {
        
        print(try! request.asURLRequest())
        
        return sessionManager
            .request(request)
            .responseCodable(queue: queue) { (response: DataResponse<T>) in
                guard
                    response.error == nil,
                    let data = response.value else {
                        print(response.error!)
                        preconditionFailure("Failure: Response was a nil")
                }
                
                completion?(data)
        }
    }
}
