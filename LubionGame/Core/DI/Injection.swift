import Foundation

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let remoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(remoteDataSource)
    }
    
    func provideHome() -> HomeUseCase {
        return HomeInteractor(repository: provideRepository())
    }
    
    func provideDetail() -> DetailUseCase {
        return DetailInteractor(repository: provideRepository())
    }
}
