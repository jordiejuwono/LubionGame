import SwiftUI

struct HomeView: View {
    let gameListPresenter = GameListPresenter(homeUseCase: Injection.init().provideHome())
    
    var body: some View {
        TabView {
            GameListView(presenter: gameListPresenter).tabItem {
                Label("Games", systemImage: "gamecontroller.fill")
            }
            Text("About").tabItem {
                Label("About", systemImage: "person.fill")
            }
        }
    }
}
