import Combine
import Common
import Foundation
import Core
import Alamofire

public protocol GetGameDetailRemoteDataSourceProtocol {
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailResponse, Error>
}

public class GetGameDetailRemoteDataSource: GetGameDetailRemoteDataSourceProtocol {
    let apiKey = "5c038203b2ea456b89aba4f076006969"
    let baseUrl = "https://api.rawg.io/api/games"
    
    public init() {}
    
    static let sharedInstance: GetGameDetailRemoteDataSource = GetGameDetailRemoteDataSource()
}

extension GetGameDetailRemoteDataSource {
    public func getGameDetail(gameId: String) -> AnyPublisher<GameDetailResponse, Error> {
        let parameters: Parameters = [
            "key": apiKey
        ]
        return Future<GameDetailResponse, Error> { completion in
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
