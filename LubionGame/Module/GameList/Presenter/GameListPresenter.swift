import Foundation
import SwiftUI
import Combine

class GameListPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    let gameListRouter = GameListRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var gameList: [ResultModel] = []
    @Published var indieGameList: [ResultModel] = []
    @Published var randomGame: ResultModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGameList() {
        isLoading = true
        homeUseCase.getGameList(query: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished: self.getIndieGameList()
                }
            }, receiveValue: { gameList in
                self.gameList = gameList.results ?? []
                self.randomGame = gameList.results?.randomElement()
            }).store(in: &cancellables)
    }
    
    func getIndieGameList() {
        homeUseCase.getIndieGameList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
                print(completion)
            }, receiveValue: { gameList in
                print(gameList)
                self.indieGameList = gameList.results ?? []
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
    
    func searchLinkBuilder<Content: View>(
        for query: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: gameListRouter.makeSearchView(for: query)) {
            content()
        }
    }
}
