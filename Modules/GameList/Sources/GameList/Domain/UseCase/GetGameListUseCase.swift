import Combine
import Common

public protocol GetGameListUseCase {
    func getGameList(query search: String?) -> AnyPublisher<GameListModel, Error>
    func getIndieGameList() -> AnyPublisher<GameListModel, Error>
}

public class GetGameListInteractor: GetGameListUseCase {
    private let repository: GetGameListRepositoryProtocol
    
    public required init(repository: GetGameListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGameList(query search: String?) -> AnyPublisher<GameListModel, Error> {
        return repository.getGameList(query: search)
    }
    
    public func getIndieGameList() -> AnyPublisher<GameListModel, Error> {
        return repository.getIndieGameList()
    }
}
