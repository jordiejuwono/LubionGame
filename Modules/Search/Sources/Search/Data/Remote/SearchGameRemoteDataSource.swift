import CorePackage
import Common
import Combine
import Alamofire
import Foundation

public protocol SearchGameRemoteDataSourceProtocol: AnyObject {
    func searchGame(query search: String?) -> AnyPublisher<GameListResponse, Error>
}

public class SearchGameRemoteDataSource: SearchGameRemoteDataSourceProtocol {
    
    public init() {}
    
    let apiKey = "5c038203b2ea456b89aba4f076006969"
    let baseUrl = "https://api.rawg.io/api/games"
    
    static let sharedInstance: SearchGameRemoteDataSource = SearchGameRemoteDataSource()
}

extension SearchGameRemoteDataSource {
    public func searchGame(query search: String?) -> AnyPublisher<GameListResponse, Error> {
        let parameters: Parameters = [
            "key": apiKey,
            "search": search ?? ""
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
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
