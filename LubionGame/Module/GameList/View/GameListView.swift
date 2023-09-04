import SwiftUI

struct GameListView: View {
    
    @ObservedObject var presenter: GameListPresenter
    @State private var searchQuery: String = ""
    @State private var isNavigationActive: Bool = false
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingView()
            } else {
                NavigationView {
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "magnifyingglass").foregroundColor(Color.gray).padding(.leading, 12)
                                TextField("Search for games...", text: $searchQuery)
                                    .padding(.leading, 3)
                                    .padding(.vertical, 12)
                                    .onSubmit {
                                        isNavigationActive = true
                                    }
                                .navigationDestination(
                                    isPresented: $isNavigationActive) {
                                        self.presenter.gameListRouter.makeSearchView(for: searchQuery)
                                    }
                            }.overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            ).background(Capsule().fill(Color.gray.opacity(0.1))).padding(.horizontal, 12).padding(.top, 12).padding(.bottom, 5)
                            if let gameData = self.presenter.randomGame {
                                self.presenter.linkBuilder(for: String(gameData.id ?? 0)) {
                                    GameHeaderItem(gameData: gameData)
                                }
                            }
                            Text("Popular Games").bold().font(.system(size: 22)).padding(.leading).padding(.top, 12)
                            Text("Explore some Popular Games").bold().font(.system(size: 12)).padding(.leading).foregroundColor(Color.gray)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .center) {
                                    ForEach(
                                        self.presenter.gameList,
                                        id: \.id
                                    ) { gameList in
                                        self.presenter.linkBuilder(for: String(gameList.id!)) {
                                            TopSectionRowItem(gameData: gameList, genres: gameList.genres ?? [])
                                        }
                                    }
                                }
                            }
                            Text("Indie Games").bold().font(.system(size: 22)).padding(.leading).padding(.top, 8)
                            Text("Support Indie Games and Developers").bold().font(.system(size: 12)).padding(.leading).foregroundColor(Color.gray)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .center) {
                                    ForEach(
                                        self.presenter.indieGameList,
                                        id: \.id
                                    ) { gameList in
                                        self.presenter.linkBuilder(for: String(gameList.id!)) {
                                            CategorySectionRowItem(gameData: gameList, genres: gameList.genres ?? [])
                                        }
                                    }
                                }.padding(.bottom, 20)
                            }
                        }
                    }
                }
                
            }
        }.onAppear {
            if self.presenter.gameList.count == 0 {
                self.presenter.getGameList()
            }
        }.navigationBarTitle(Text("Lubion Game"), displayMode: .automatic)
    }
    
}
