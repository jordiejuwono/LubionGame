import SwiftUI

struct CategorySectionRowItem: View {
    var gameData: ResultModel
    var genres: [GenreModel]?
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: gameData.backgroundImage ?? "")) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()
            
            VStack {
                Text(gameData.name ?? "").bold().frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color.black)
                if let genres = genres {
                    Text(genres.map { $0.name ?? "" }.joined(separator: ", ")).font(.system(size: 12)).foregroundColor(Color.gray).bold().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.bottom, 3)
                }
                HStack {
                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                    Text(String(format: "%.1f", gameData.rating ?? 0.0)).font(.system(size: 12)).bold().foregroundColor(Color.black)
                    Spacer()
                }
            }
        }.padding(.leading)
    }
}
