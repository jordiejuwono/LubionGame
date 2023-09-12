import Combine
import CorePackage
import Common

public protocol GetGameListRepositoryProtocol {
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, Error>
    func getIndieGameList() -> AnyPublisher<GameListModel, Error>
}

public class GetGameListRepository<Transformer: Mapper>: GetGameListRepositoryProtocol where Transformer.Entity == GameListModel, Transformer.Response == GameListResponse, Transformer.Domain == GameListModel {
    public let _remoteDataSource: GetGameListRemoteDataSourceProtocol
    public let _mapper: Transformer
    
    public init(
        remoteDataSource: GetGameListRemoteDataSourceProtocol,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func getGameList(query search: String?) -> AnyPublisher<GameListModel, Error> {
        return self._remoteDataSource.getGameList(query: search)
            .map {
                self._mapper.transformResponseToEntity(response: $0)
            }.eraseToAnyPublisher()
    }
    
    public func getIndieGameList() -> AnyPublisher<GameListModel, Error> {
        return self._remoteDataSource.getIndieGameList()
            .map {
                self._mapper.transformResponseToEntity(response: $0)
            }.eraseToAnyPublisher()
    }
    
}
