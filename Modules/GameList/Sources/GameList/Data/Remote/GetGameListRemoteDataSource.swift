import CorePackage
import Common
import Combine
import Alamofire
import Foundation

public protocol GetGameListRemoteDataSourceProtocol: AnyObject {
    func getGameList(query search: String?) -> AnyPublisher<GameListResponse, Error>
    func getIndieGameList() -> AnyPublisher<GameListResponse, Error>
}

public class GetGameListRemoteDataSource: GetGameListRemoteDataSourceProtocol {
    
    public init() {}
    
    let apiKey = "5c038203b2ea456b89aba4f076006969"
    let baseUrl = "https://api.rawg.io/api/games"
    
    static let sharedInstance: GetGameListRemoteDataSource = GetGameListRemoteDataSource()
}

extension GetGameListRemoteDataSource {
    public func getGameList(query search: String?) -> AnyPublisher<GameListResponse, Error> {
        var parameters: Parameters = [
            "key": apiKey
        ]
        if search != nil {
            parameters["search"] = search
        }
        return Future<GameListResponse, Error> { completion in
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
    
    public func getIndieGameList() -> AnyPublisher<GameListResponse, Error> {
        let parameters: Parameters = [
            "key": apiKey,
            "genres": "51"
        ]
        return Future<GameListResponse, Error> { completion in
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

}
