import Combine

public protocol LocalDataSource {
    associatedtype Request
    associatedtype Response
    
    func getList() -> AnyPublisher<Response, Error>
    func add(entity: Response) -> AnyPublisher<Bool, Error>
    func delete(id: Int) -> AnyPublisher<Bool, Error>
    func isFavorited(id: Int) -> AnyPublisher<Bool, Error>
}
