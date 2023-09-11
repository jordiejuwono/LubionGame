import SwiftUI

struct SearchView: View {
    
    var query: String
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingView()
            } else if presenter.isEmpty {
                EmptyDataView(emptyText: "No Game Found")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .center) {
                        ForEach(
                            self.presenter.searchResults,
                            id: \.id
                        ) { gameList in
                            self.presenter.linkBuilder(for: String(gameList.id ?? 0)) {
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
                                    
                                    Text(gameList.name ?? "").bold().frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).foregroundColor(Color.black)
                                }.padding(.leading)
                            }
                        }
                    }.padding(.top)
                }
            }
        }.onAppear {
//            self.presenter.getGameList(query: query)
        }.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Search results for \"\(query)\"").bold()
                }
            }
    }
    
}
