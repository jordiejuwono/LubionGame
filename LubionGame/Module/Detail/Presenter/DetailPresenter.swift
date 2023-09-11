import Foundation
import Combine
import Detail
import Favorite

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let detailUseCase: GetGameDetailUseCase
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var gameDetail: GameDetailModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isFavorited: Bool = false
    
    init(detailUseCase: GetGameDetailUseCase, favoriteUseCase: FavoriteUseCase) {
        self.detailUseCase = detailUseCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getGameDetail(gameId: String) {
        isLoading = true
        detailUseCase.getGameDetail(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { gameDetail in
                self.gameDetail = gameDetail
            }).store(in: &cancellables)
    }

    func addFavoriteGame(game gameModel: GameTableModel) {
        favoriteUseCase.addFavoriteGame(game: gameModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.isFavorited(id: gameModel.id ?? 0)
            }).store(in: &cancellables)
    }
    
    func deleteFavorite(id gameId: Int) {
        favoriteUseCase.deleteFavorite(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.isFavorited(id: gameId)
            }).store(in: &cancellables)
    }

    func isFavorited(id gameId: Int) {
        favoriteUseCase.isFavorited(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in

            }, receiveValue: { isFavorited in
                self.isFavorited = isFavorited
            }).store(in: &cancellables)
    }
}
