import Foundation
import Favorite
import CorePackage
import RealmSwift
import Common
import GameList
import Detail
import Search

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
    func provideGetGameList() -> GetGameListUseCase {
        let dataSource = GetGameListRemoteDataSource()
        let mapper = GameListTransformer()
        let repository = GetGameListRepository(remoteDataSource: dataSource, mapper: mapper)
        
        return GetGameListInteractor(repository: repository)
    }
    
    func provideGetGameDetail() -> GetGameDetailUseCase {
        let dataSource = GetGameDetailRemoteDataSource()
        let mapper = GameDetailTransformer()
        let repository = GetGameDetailRepository(remoteDataSource: dataSource, mapper: mapper)
        
        return GetGameDetailInteractor(repository: repository)
    }
    
    func provideGameFavorite() -> FavoriteUseCase {
        let dataSource = FavoriteLocalDataSource(realm: realm!)
        let mapper = FavoriteGamesTransformer()
        let repository = FavoriteRepository(local: dataSource, mapper: mapper)
        
        return FavoriteInteractor(repository: repository)
    }
    
    func provideSearchGame() -> SearchGameUseCase {
        let dataSource = SearchGameRemoteDataSource()
        let mapper = GameListTransformer()
        let repository = SearchGameRepository(remoteDataSource: dataSource, mapper: mapper)
        
        return SearchGameInteractor(repository: repository)
    }
    
//    func provideGetGameList<U: UseCase>() -> U where U.Request == Any, U.Response == GameListModel {
//        let remote = GetGameListRemoteDataSource()
//        let mapper = GameListTransformer()
//        let repository = GetGameListRepository(remoteDataSource: remote, mapper: mapper)
//
//        return Interactor(repository: repository) as! U
//    }
    
//    private func provideRepository() -> GameRepositoryProtocol {
//        let realm = try? Realm()
//        let remoteDataSource = RemoteDataSource.sharedInstance
//        let localDataSource = LocalDataSource.sharedInstance(realm)
//
//        return GameRepository.sharedInstance(remoteDataSource, localDataSource)
//    }
    
//    func provideHome() -> HomeUseCase {
//        return HomeInteractor(repository: provideRepository())
//    }
    
//    func provideDetail() -> DetailUseCase {
//        return DetailInteractor(repository: provideRepository())
//    }
    
//    func provideFavorite() -> FavoriteUseCase {
//        return FavoriteInteractor(repository: provideRepository())
//    }
//
//    func provideSearch() -> SearchUseCase {
//        return SearchInteractor(repository: provideRepository())
//    }
}
