import Foundation
import Combine

protocol DetailUseCase {
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, ServerError> {
        return repository.getGameDetail(gameId: gameId)
    }
    
}
