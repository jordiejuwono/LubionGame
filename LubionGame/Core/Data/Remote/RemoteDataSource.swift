import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<GameListResponse, ServerError>
    func getIndieGameList() -> AnyPublisher<GameListResponse, ServerError>
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailResponse, ServerError>
    func getGameTrailers(gameId: String) -> AnyPublisher<GameTrailersResponse, ServerError>
}

class RemoteDataSource: NSObject {
    let apiKey = "5c038203b2ea456b89aba4f076006969"
    
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGameList() -> AnyPublisher<GameListResponse, ServerError> {
        let parameters: Parameters = [
            "key": apiKey
        ]
        return Future<GameListResponse, ServerError> { completion in
            if let url = URL(string: "https://api.rawg.io/api/games") {
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
            if let url = URL(string: "https://api.rawg.io/api/games") {
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
            if let url = URL(string: "https://api.rawg.io/api/games/\(gameId)") {
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
    
    func getGameTrailers(gameId: String) -> AnyPublisher<GameTrailersResponse, ServerError> {
        let parameters: Parameters = [
            "key": apiKey
        ]
        return Future<GameTrailersResponse, ServerError> { completion in
            if let url = URL(string: "https://api.rawg.io/api/games/\(gameId)/movies") {
                AF.request(
                    url,
                    method: .get,
                    parameters: parameters
                ).validate()
                    .responseDecodable(of: GameTrailersResponse.self) { response in
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
