import Foundation
import Combine
import CorePackage

public protocol FavoriteUseCase {
    func getFavoritedGames() -> AnyPublisher<[GameTableModel], Error>
    func addFavoriteGame(game gameModel: GameTableModel) -> AnyPublisher<Bool, Error>
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, Error>
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let repository: FavoriteRepository<FavoriteLocalDataSource>
    
    public required init(repository: FavoriteRepository<FavoriteLocalDataSource>) {
        self.repository = repository
    }
    
    public func getFavoritedGames() -> AnyPublisher<[GameTableModel], Error> {
        return repository.getFavoritedGames()
    }
    
    public func addFavoriteGame(game gameModel: GameTableModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(game: gameModel)
    }
    
    public func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(id: gameId)
    }
    
    public func isFavorited(id gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.isFavorited(id: gameId)
    }
}
