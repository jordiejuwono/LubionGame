//import Foundation
//import Common
//import Combine
//
//protocol HomeUseCase {
//    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError>
//    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError>
//}
//
//class HomeInteractor: HomeUseCase {
//
//    private let repository: GameRepositoryProtocol
//
//    required init(repository: GameRepositoryProtocol) {
//        self.repository = repository
//    }
//
//    func getGameList(query search: String?) -> AnyPublisher<GameListModel, ServerError> {
//        return repository.getGameList(query: search)
//    }
//
//    func getIndieGameList() -> AnyPublisher<GameListModel, ServerError> {
//        return repository.getIndieGameList()
//    }
//
//}
