import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let detailUseCase: DetailUseCase
    
    @Published var gameDetail: GameDetailModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isFavorited: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
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
        detailUseCase.addFavoriteGame(game: gameModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.isFavorited(id: gameModel.id ?? 0)
            }).store(in: &cancellables)
    }
    
    func deleteFavorite(id gameId: Int) {
        detailUseCase.deleteFavorite(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.isFavorited(id: gameId)
            }).store(in: &cancellables)
    }
    
    func isFavorited(id gameId: Int) {
        detailUseCase.isFavorited(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { isFavorited in
                self.isFavorited = isFavorited
            }).store(in: &cancellables)
    }
}
