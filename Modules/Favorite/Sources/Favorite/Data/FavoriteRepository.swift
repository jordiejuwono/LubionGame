import RealmSwift
import Core
import Combine

public class FavoriteRepository<FavoriteLocalDataSource: LocalDataSource> where FavoriteLocalDataSource.Request == Any, FavoriteLocalDataSource.Response == GameEntity {
    public typealias GameInstance = (FavoriteLocalDataSource) -> FavoriteRepository

    fileprivate let local: FavoriteLocalDataSource
    fileprivate let mapper: FavoriteGamesTransformer

    public init(local: FavoriteLocalDataSource, mapper: FavoriteGamesTransformer) {
        self.local = local
        self.mapper = mapper
    }

    public let sharedInstance: GameInstance = { local in
        return FavoriteRepository(local: local, mapper: FavoriteGamesTransformer())
    }
}

extension FavoriteRepository {
    public func getFavoritedGames() -> AnyPublisher<[GameTableModel], Error> {
        return self.local.getList().map {
            self.mapper.mapGamesEntityToDomains(input: $0)
        }.eraseToAnyPublisher()
    }

    public func addFavorite(game gameModel: GameTableModel) -> AnyPublisher<Bool, Error> {
        return self.local.add(entity: self.mapper.mapGameDomainToEntities(input: gameModel)).eraseToAnyPublisher()
    }

    public func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.local.delete(id: gameId).eraseToAnyPublisher()
    }
    
    public func isFavorited(id gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.local.isFavorited(id: gameId).eraseToAnyPublisher()
    }
}
