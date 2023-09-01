import SwiftUI

struct GameListView: View {
    
    @ObservedObject var presenter: GameListPresenter
    @State private var searchQuery: String = ""
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    ProgressView()
                    Spacer().frame(height: 5)
                    Text("Loading")
                }
            } else {
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(Color.gray).padding(.leading, 12)
                            TextField("Search for games...", text: $searchQuery).padding(.leading, 3).padding(.vertical, 12)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        ).background(Capsule().fill(Color.gray.opacity(0.1))).padding(12)
                        if let gameData = self.presenter.randomGame {
                            ZStack(alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: gameData.backgroundImage ?? "")) { image in
                                    image.resizable()
                                  } placeholder: {
                                      ProgressView().frame(height: 240)
                                  }
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 240)
                                    .clipped()
                                
                                HStack {
                                    Text(gameData.name ?? "").bold().foregroundColor(Color.white)
                                    Spacer()
                                    Image(systemName: "star.fill").resizable().frame(width: 16, height: 16).foregroundColor(Color.yellow)
                                    Text(String(gameData.rating ?? 0.0)).foregroundColor(Color.white).font(.system(size: 14)).bold()
                                }.padding(12).frame(maxWidth: .infinity, alignment: .leading).background(Color.black.opacity(0.5))
                            }
                        }
                        Text("Popular Games").bold().font(.system(size: 22)).padding(.leading).padding(.top)
                        Text("Explore some popular games").bold().font(.system(size: 12)).padding(.leading).foregroundColor(Color.gray)
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
                        Text("Recommended For You").bold().font(.system(size: 22)).padding(.leading).padding(.top)
                        Text("Explore games that maybe you will like").bold().font(.system(size: 12)).padding(.leading).foregroundColor(Color.gray)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(alignment: .center) {
                                ForEach(
                                    self.presenter.gameList,
                                    id: \.id
                                ) { gameList in
                                    HStack {
                                        AsyncImage(url: URL(string: gameList.backgroundImage ?? "")) { image in
                                            image.resizable()
                                          } placeholder: {
                                            ProgressView()
                                          }
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(12)
                                            .clipped()
                                        
                                        VStack {
                                            Text(gameList.name ?? "").bold().frame(maxWidth: .infinity, alignment: .leading)
                                            if let genres = gameList.genres {
                                                Text(genres.map { $0.name ?? "" }.joined(separator: ", ")).font(.system(size: 12)).foregroundColor(Color.gray).bold().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.bottom, 3)
                                            }
                                            HStack {
                                                Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                                                Text(String(gameList.rating ?? 0.0)).font(.system(size: 12)).bold()
                                                Spacer()
                                            }
                                        }
                                    }.padding(.leading)
                                }
                            }
                        }
                        Text("Top Games 3").bold().font(.system(size: 18)).padding(.leading).padding(.top)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(alignment: .center) {
                                ForEach(
                                    self.presenter.gameList,
                                    id: \.id
                                ) { gameList in
                                    HStack {
                                        AsyncImage(url: URL(string: gameList.backgroundImage ?? "")) { image in
                                            image.resizable()
                                          } placeholder: {
                                            ProgressView()
                                          }
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(12)
                                            .clipped()
                                        
                                        VStack {
                                            Text(gameList.name ?? "").bold().frame(maxWidth: .infinity, alignment: .leading)
                                            if let genres = gameList.genres {
                                                Text(genres.map { $0.name ?? "" }.joined(separator: ", ")).font(.system(size: 12)).foregroundColor(Color.gray).bold().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.bottom, 3)
                                            }
                                            HStack {
                                                Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                                                Text(String(gameList.rating ?? 0.0)).font(.system(size: 12)).bold()
                                                Spacer()
                                            }
                                        }
                                    }.padding(.leading)
                                }
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
