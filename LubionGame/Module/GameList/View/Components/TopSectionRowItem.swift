import SwiftUI

struct TopSectionRowItem: View {
    var gameData: ResultModel
    var genres: [GenreModel]
    
    var body: some View {
        VStack(spacing: 0) {
            gameImage
            gameTitle
            gameGenres
            gameRating
        }.frame(width: 200).cornerRadius(12).padding(.leading)
    }
}

extension TopSectionRowItem {
    var gameImage: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: gameData.backgroundImage ?? "")) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 140)
                .cornerRadius(12)
                .clipped()
                .padding(.bottom, 5)
        }
    }
    
    var gameTitle: some View {
        Text(gameData.name ?? "").foregroundColor(Color.black).lineLimit(1).bold().frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 2).padding(.leading, 3)
    }
    
    var gameGenres: some View {
        Text(genres.map { $0.name ?? "" }.joined(separator: ", ")).font(.system(size: 12)).foregroundColor(Color.gray).bold().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.leading, 5).padding(.bottom, 5)
    }
    
    var gameRating: some View {
        HStack {
            Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
            Text(String(format: "%.1f", gameData.rating ?? 0.0)).foregroundColor(Color.black).font(.system(size: 12)).bold()
            Spacer()
        }.padding(.bottom, 8).padding(.leading, 5)
    }
}
