import Combine
import CorePackage
import Common

public protocol SearchGameRepositoryProtocol {
    func searchGame(query search: String?) -> AnyPublisher<GameListModel, Error>
}

public class SearchGameRepository<Transformer: Mapper>: SearchGameRepositoryProtocol where Transformer.Entity == GameListModel, Transformer.Response == GameListResponse, Transformer.Domain == GameListModel {
    public let _remoteDataSource: SearchGameRemoteDataSourceProtocol
    public let _mapper: Transformer
    
    public init(
        remoteDataSource: SearchGameRemoteDataSourceProtocol,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func searchGame(query search: String?) -> AnyPublisher<GameListModel, Error> {
        return self._remoteDataSource.searchGame(query: search)
            .map {
                self._mapper.transformResponseToEntity(response: $0)
            }.eraseToAnyPublisher()
    }
    
}
