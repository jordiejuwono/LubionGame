import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingView()
            } else if presenter.isEmpty {
                EmptyDataView(emptyText: "No Favorite\nGame Yet")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .center) {
                        ForEach(
                            self.presenter.favoritedGames,
                            id: \.id
                        ) { gameList in
                            self.presenter.linkBuilder(for: String(gameList.id!)) {
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
                                    
                                    Text(gameList.name ?? "").bold().frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color.black)
                                }.padding(.leading)
                            }
                        }
                    }
                }
            }
        }.onAppear {
            self.presenter.getFavoritedGames()
        }.navigationBarTitle(Text("Lubion Game"), displayMode: .automatic)
    }
    
}
