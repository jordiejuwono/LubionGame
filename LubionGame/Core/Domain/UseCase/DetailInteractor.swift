import Foundation
import Combine

protocol DetailUseCase {
//    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError>
//    func addFavoriteGame(game gameModel: GameTableModel) -> AnyPublisher<Bool, DatabaseError>
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
//    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError> {
//        return repository.getGameDetail(gameId: gameId)
//    }
//
//    func addFavoriteGame(game gameModel: GameTableModel) -> AnyPublisher<Bool, DatabaseError> {
//        return repository.addFavorite(game: gameModel)
//    }
    
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return repository.deleteFavorite(id: gameId)
    }
    
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return repository.isFavorited(id: gameId)
    }
    
}
