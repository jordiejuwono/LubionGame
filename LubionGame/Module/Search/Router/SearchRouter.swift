import SwiftUI

class SearchRouter {
    
    func makeDetailView(for gameId: String) -> some View {
        let detailUseCase = Injection.init().provideDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        
        return DetailView(gameId: gameId, detailPresenter: presenter)
    }
    
}
