import Combine
import CorePackage
import Common

public protocol GetGameDetailRepositoryProtocol {
        func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, Error>
}

public class GetGameDetailRepository<Transformer: Mapper>: GetGameDetailRepositoryProtocol where Transformer.Entity == GameDetailModel, Transformer.Response == GameDetailResponse, Transformer.Domain == GameDetailModel {
    public let _remoteDataSource: GetGameDetailRemoteDataSourceProtocol
    public let _mapper: Transformer
    
    public init(
        remoteDataSource: GetGameDetailRemoteDataSourceProtocol,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, Error> {
        return self._remoteDataSource.getGameDetail(gameId: gameId).map {
            self._mapper.transformResponseToEntity(response: $0)
        }.eraseToAnyPublisher()
    }
    
}
