import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getGameList() -> AnyPublisher<GameListModel, ServerError>
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError>
}

class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { remote in
        return GameRepository(remote: remote)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGameList() -> AnyPublisher<GameListModel, ServerError> {
        return self.remote.getGameList()
            .map { GameMapper.mapGameListResponseToDomains(input: $0) }.eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError> {
        return self.remote.getGameDetail(gameId: gameId).map { GameMapper.mapGameDetailResponseToDomains(input: $0) }.eraseToAnyPublisher()
    }
}
