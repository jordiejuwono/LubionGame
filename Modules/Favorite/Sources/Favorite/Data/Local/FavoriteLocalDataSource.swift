import CorePackage
import Combine
import RealmSwift

public class FavoriteLocalDataSource: LocalDataSource {
    public typealias Request = Any
    
    public typealias Response = GameEntity
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public let sharedInstance: (Realm?) -> FavoriteLocalDataSource = { realmDatabase in
        return FavoriteLocalDataSource(realm: realmDatabase)
    }
    
    
    public func getList() -> AnyPublisher<[Response], Error> {
        return Future<[Response], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func add(entity: Response) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(entity)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let gameObject = realm.object(ofType: GameEntity.self, forPrimaryKey: id) {
                            realm.delete(gameObject)
                        } else {
                            completion(.failure(DatabaseError.requestFailed))
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.invalidInstance))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func isFavorited(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let gameData = realm.object(ofType: GameEntity.self, forPrimaryKey: id)
                if gameData != nil {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
}
