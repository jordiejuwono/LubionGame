import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
