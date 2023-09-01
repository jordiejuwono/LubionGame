//import Foundation
//import Combine
//
//class HomePresenter: ObservableObject {
//    private var cancellables: Set<AnyCancellable> = []
//    
//    private let homeUseCase: HomeUseCase
//    
//    @Published var gameList: [ResultModel] = []
//    @Published var errorMessage: String = ""
//    @Published var isLoading: Bool = false
//    
//    init(homeUseCase: HomeUseCase) {
//        self.homeUseCase = homeUseCase
//    }
//    
//    func getGameList() {
//        isLoading = true
//        homeUseCase.getGameList()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure:
//                    self.errorMessage = String(describing: completion)
//                case .finished:
//                    self.isLoading = false
//                }
//            }, receiveValue: { gameList in
//                self.gameList = gameList.results ?? []
//            }).store(in: &cancellables)
//    }
//}
