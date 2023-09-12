import Foundation
import Favorite
import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let favoriteUseCase: FavoriteUseCase
    private let favoriteRouter = FavoriteRouter()
    
    @Published var favoritedGames: [GameTableModel] = []
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var errorMessage: String = ""
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoritedGames() {
        isLoading = true
        favoriteUseCase.getFavoritedGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { gameList in
                if gameList.isEmpty {
                    self.isEmpty = true
                } else {
                    self.isEmpty = false
                    self.favoritedGames = gameList
                }
            }).store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for gameId: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: favoriteRouter.makeDetailView(for: gameId)) {
            content()
        }
    }
    
}
