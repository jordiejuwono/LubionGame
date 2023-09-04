import Foundation
import Combine

protocol GameRepositoryProtocol {
    // Remote
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError>
    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError>
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError>
    // Local
    func getFavoritedGames() -> AnyPublisher<[GameTableModel], DatabaseError>
    func addFavorite(game gameModel: GameTableModel) -> AnyPublisher<Bool, DatabaseError>
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSourceProtocol, LocalDataSourceProtocol) -> GameRepository
    
    fileprivate let remote: RemoteDataSourceProtocol
    fileprivate let local: LocalDataSourceProtocol
    
    private init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: GameInstance = { remote, local in
        return GameRepository(remote: remote, local: local)
    }
}

extension GameRepository: GameRepositoryProtocol {
    // Remote
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError> {
        return self.remote.getGameList(query: search)
            .map { GameMapper.mapGameListResponseToDomains(input: $0) }.eraseToAnyPublisher()
    }
    
    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError> {
        return self.remote.getIndieGameList()
            .map {
                GameMapper.mapGameListResponseToDomains(input: $0)
            }.eraseToAnyPublisher()
        
    }
    
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError> {
        return self.remote.getGameDetail(gameId: gameId).map { GameMapper.mapGameDetailResponseToDomains(input: $0) }.eraseToAnyPublisher()
    }

    // Local
    func getFavoritedGames() -> AnyPublisher<[GameTableModel], DatabaseError> {
        return self.local.getFavoritedGames().map {
            GameMapper.mapGamesEntityToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(game gameModel: GameTableModel) -> AnyPublisher<Bool, DatabaseError> {
        return self.local.addFavorite(game: GameMapper.mapGameDomainToEntities(input: gameModel)).eraseToAnyPublisher()
    }
    
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return self.local.deleteFavorite(id: gameId).eraseToAnyPublisher()
    }
    
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return self.local.isFavorited(id: gameId).eraseToAnyPublisher()
    }
}
