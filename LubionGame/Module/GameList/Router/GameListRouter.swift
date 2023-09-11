import SwiftUI

class GameListRouter {
    
    func makeDetailView(for gameId: String) -> some View {
        let detailUseCase = Injection.init().provideGetGameDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        
        return DetailView(gameId: gameId, detailPresenter: presenter)
    }
    
    func makeSearchView(for query: String) -> some View {
        let searchUseCase = Injection.init().provideSearch()
        let presenter = SearchPresenter(searchUseCase: searchUseCase)
        
        return SearchView(query: query, presenter: presenter)
    }
    
}
