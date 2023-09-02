import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    func getFavoritedGames() -> AnyPublisher<[GameEntity], DatabaseError>
    func addFavorite(game gameEntity: GameEntity) -> AnyPublisher<Bool, DatabaseError>
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError>
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    func getFavoritedGames() -> AnyPublisher<[GameEntity], DatabaseError> {
        return Future<[GameEntity], DatabaseError> { completion in
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
    
    func addFavorite(game gameEntity: GameEntity) -> AnyPublisher<Bool, DatabaseError> {
        return Future<Bool, DatabaseError> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(gameEntity)
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
    
    func deleteFavorite(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return Future<Bool, DatabaseError> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let gameObject = realm.object(ofType: GameEntity.self, forPrimaryKey: gameId) {
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
    
    func isFavorited(id gameId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return Future<Bool, DatabaseError> { completion in
            if let realm = self.realm {
                let gameData = realm.object(ofType: GameEntity.self, forPrimaryKey: gameId)
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

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
