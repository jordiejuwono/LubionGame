import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        let remoteDataSource = RemoteDataSource.sharedInstance
        let localDataSource = LocalDataSource.sharedInstance(realm)
        
        return GameRepository.sharedInstance(remoteDataSource, localDataSource)
    }
    
    func provideHome() -> HomeUseCase {
        return HomeInteractor(repository: provideRepository())
    }
    
    func provideDetail() -> DetailUseCase {
        return DetailInteractor(repository: provideRepository())
    }
    
    func provideFavorite() -> FavoriteUseCase {
        return FavoriteInteractor(repository: provideRepository())
    }
}
