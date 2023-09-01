import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let detailUseCase: DetailUseCase
    
    @Published var gameDetail: GameDetailModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
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
}
