import SwiftUI
import Common

struct GameHeaderItem: View {
    var gameData: ResultModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: gameData.backgroundImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView().frame(height: 200)
            }
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)
            
            HStack {
                Text(gameData.name ?? "").bold().foregroundColor(Color.white)
                Spacer()
                Image(systemName: "star.fill").resizable().frame(width: 16, height: 16).foregroundColor(Color.yellow)
                Text(String(gameData.rating ?? 0.0)).foregroundColor(Color.white).font(.system(size: 14)).bold()
            }.padding(12).frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color.black.opacity(0.5).cornerRadius(12, corners: [.bottomLeft, .bottomRight])
//            )
        }.padding(.horizontal, 12).padding(.top, 12)
    }
}
