import SwiftUI
import GameList
import Common
import CorePackage

struct HomeView: View {
    let gameListPresenter = GameListPresenter(homeUseCase: Injection.init().provideGetGameList())
    let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideGameFavorite())
    
    var body: some View {
        TabView {
            GameListView(presenter: gameListPresenter).tabItem {
                Label("Games", systemImage: "gamecontroller.fill")
            }
            FavoriteView(presenter: favoritePresenter).tabItem {
                Label("Favorite", systemImage: "star.fill")
            }
            AboutView().tabItem {
                Label("About", systemImage: "person.fill")
            }
        }
    }
}
