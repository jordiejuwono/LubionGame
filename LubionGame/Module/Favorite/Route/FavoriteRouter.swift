import SwiftUI

class FavoriteRouter {
    
    func makeDetailView(for gameId: String) -> some View {
        let detailUseCase = Injection.init().provideGetGameDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        
        return DetailView(gameId: gameId, detailPresenter: presenter)
    }
    
}
