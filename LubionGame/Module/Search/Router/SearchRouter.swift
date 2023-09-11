import SwiftUI

class SearchRouter {
    
    func makeDetailView(for gameId: String) -> some View {
        let detailUseCase = Injection.init().provideGetGameDetail()
        let favoriteUseCase = Injection.init().provideGameFavorite()
        let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
        
        return DetailView(gameId: gameId, detailPresenter: presenter)
    }
    
}
