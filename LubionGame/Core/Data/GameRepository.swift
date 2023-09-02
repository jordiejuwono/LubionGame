import Foundation
import Combine

protocol GameRepositoryProtocol {
    // Remote
    func getGameList() -> AnyPublisher<GameListModel, ServerError>
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError>
    // Local
    func getFavoritedGames() -> AnyPublisher<[GameTableModel], DatabaseError>
    func addFavorite(game gameModel: GameTableModel) -> AnyPublisher<Bool, DatabaseError>
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSource, LocalDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: GameInstance = { remote, local in
        return GameRepository(remote: remote, local: local)
    }
}

extension GameRepository: GameRepositoryProtocol {
    // Remote
    func getGameList() -> AnyPublisher<GameListModel, ServerError> {
        return self.remote.getGameList()
            .map { GameMapper.mapGameListResponseToDomains(input: $0) }.eraseToAnyPublisher()
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
    
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return self.local.isFavorited(id: gameId).eraseToAnyPublisher()
    }
}
