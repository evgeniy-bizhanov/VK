import Alamofire

extension DataRequest {
    
    typealias Completion<T> = (DataResponse<T>) -> Void
    
    /**
     Создает пользовательский `JSON` сериализатор и передает его в `Alamofire`
     для распаковки ответа сервера
     */
    @discardableResult func responseCodable<T: Decodable>(
        queue: DispatchQueue?,
        completion: @escaping Completion<T>) -> Self {
        
        let responseSerializer = DataResponseSerializer<T> { _, response, data, error in
            
            let result = Request.serializeResponseData(response: response, data: data, error: error)
            
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    return .success(json)
                } catch {
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        }

        return response(
            queue: queue,
            responseSerializer: responseSerializer,
            completionHandler: completion
        )
    }
}
