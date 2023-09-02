import Foundation
import Combine

protocol HomeUseCase {
    func getGameList() -> AnyPublisher<GameListModel, ServerError>
    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameList() -> AnyPublisher<GameListModel, ServerError> {
        return repository.getGameList()
    }
    
    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError> {
        return repository.getIndieGameList()
    }
    
}
