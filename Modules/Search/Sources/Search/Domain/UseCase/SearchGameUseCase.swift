import Combine
import Common

public protocol SearchGameUseCase {
    func searchGame(query search: String?) -> AnyPublisher<GameListModel, Error>
}

public class SearchGameInteractor: SearchGameUseCase {
    private let repository: SearchGameRepositoryProtocol
    
    public required init(repository: SearchGameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchGame(query search: String?) -> AnyPublisher<GameListModel, Error> {
        return repository.searchGame(query: search)
    }
}
