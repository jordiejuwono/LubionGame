//import Foundation
//import Common
//import Combine
//import SwiftUI
//
//class SearchPresenter: ObservableObject {
//    private var cancellables: Set<AnyCancellable> = []
//
//    private let searchUseCase: SearchUseCase
//    private let searchRouter = SearchRouter()
//
//    @Published var searchResults: [ResultModel] = []
//    @Published var isLoading: Bool = false
//    @Published var isEmpty: Bool = false
//    @Published var errorMessage: String = ""
//
//    init(searchUseCase: SearchUseCase) {
//        self.searchUseCase = searchUseCase
//    }
//
////    func getGameList(query search: String) {
////        isLoading = true
////        searchUseCase.getGameList(query: search)
////            .receive(on: RunLoop.main)
////            .sink(receiveCompletion: { completion in
////                switch completion {
////                case .failure:
////                    self.errorMessage = String(describing: completion)
////                case .finished: self.isLoading = false
////                }
////            }, receiveValue: { gameList in
////                self.searchResults = gameList.results ?? []
////            }).store(in: &cancellables)
////    }
//
//    func linkBuilder<Content: View>(
//        for gameId: String,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        NavigationLink(destination: searchRouter.makeDetailView(for: gameId)) {
//            content()
//        }
//    }
//
//}
