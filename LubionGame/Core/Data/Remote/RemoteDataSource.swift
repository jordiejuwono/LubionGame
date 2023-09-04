import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getGameList(query search: String?) -> AnyPublisher<GameListResponse, ServerError>
    func getIndieGameList() -> AnyPublisher<GameListResponse, ServerError>
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailResponse, ServerError>
}

class RemoteDataSource: NSObject {
    let apiKey = "5c038203b2ea456b89aba4f076006969"
    let baseUrl = "https://api.rawg.io/api/games"
    
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGameList(query search: String?) -> AnyPublisher<GameListResponse, ServerError> {
        var parameters: Parameters = [
            "key": apiKey
        ]
        if search != nil {
            parameters["search"] = search
        }
        return Future<GameListResponse, ServerError> { completion in
            if let url = URL(string: self.baseUrl) {
                AF.request(
                    url,
                    method: .get,
                    parameters: parameters
                ).validate()
                    .responseDecodable(of: GameListResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(ServerError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getIndieGameList() -> AnyPublisher<GameListResponse, ServerError> {
        let parameters: Parameters = [
            "key": apiKey,
            "genres": "51"
        ]
        return Future<GameListResponse, ServerError> { completion in
            if let url = URL(string: self.baseUrl) {
                AF.request(
                    url,
                    method: .get,
                    parameters: parameters
                ).validate()
                    .responseDecodable(of: GameListResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(ServerError.invalidResponse))
                        }
                    }.response { result in
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailResponse, ServerError> {
        let parameters: Parameters = [
            "key": apiKey
        ]
        return Future<GameDetailResponse, ServerError> { completion in
            if let url = URL(string: "\(self.baseUrl)/\(gameId)") {
                AF.request(
                    url,
                    method: .get,
                    parameters: parameters
                ).validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(ServerError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
