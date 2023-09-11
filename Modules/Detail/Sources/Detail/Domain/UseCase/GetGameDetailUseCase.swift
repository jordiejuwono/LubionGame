import Foundation
import Combine

public protocol GetGameDetailUseCase {
    func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, Error>
}

public class GetGameDetailInteractor: GetGameDetailUseCase {
    
    private let repository: GetGameDetailRepositoryProtocol
    
    public required init(repository: GetGameDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGameDetail(gameId: String) -> AnyPublisher<GameDetailModel, Error> {
        return repository.getGameDetail(gameId: gameId)
    }
    
}
