import SwiftUI

class GameListRouter {
    
    func makeDetailView(for gameId: String) -> some View {
        let detailUseCase = Injection.init().provideGetGameDetail()
        let favoriteUseCase = Injection.init().provideGameFavorite()
        let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
        
        return DetailView(gameId: gameId, detailPresenter: presenter)
    }
    
//    func makeSearchView(for query: String) -> some View {
//        let searchUseCase = Injection.init().provideSearch()
//        let presenter = SearchPresenter(searchUseCase: searchUseCase)
//
//        return SearchView(query: query, presenter: presenter)
//    }
    
}
