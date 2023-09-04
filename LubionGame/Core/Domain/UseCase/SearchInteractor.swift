import Foundation
import Combine

protocol SearchUseCase {
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError>
}

class SearchInteractor: SearchUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError> {
        return repository.getGameList(query: search)
    }
}
