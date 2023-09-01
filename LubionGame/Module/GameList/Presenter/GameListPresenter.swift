import Foundation
import SwiftUI
import Combine

class GameListPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let gameListRouter = GameListRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var gameList: [ResultModel] = []
    @Published var randomGame: ResultModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGameList() {
        isLoading = true
        homeUseCase.getGameList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { gameList in
                self.gameList = gameList.results ?? []
                self.randomGame = gameList.results?.randomElement()
            }).store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for gameId: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: gameListRouter.makeDetailView(for: gameId)) {
            content()
        }
    }
}
