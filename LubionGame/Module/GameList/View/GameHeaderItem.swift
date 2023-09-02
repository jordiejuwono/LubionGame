import SwiftUI

struct GameHeaderItem: View {
    var gameData: ResultModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: URL(string: gameData.backgroundImage ?? "")) { image in
                    image.resizable()
                  } placeholder: {
                      ProgressView().frame(height: 180)
                  }
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .blur(radius: 5)
                    .clipped()
                
                Color.black.frame(maxWidth: .infinity, maxHeight: 180).opacity(0.70)
            }.cornerRadius(12)
            
            
            GeometryReader { geo in
                VStack {
                    Text("Check Your Favorite Game Categories").frame(maxWidth: geo.size.width * 0.5).font(.system(size: 16)).bold().foregroundColor(Color.white).padding(.bottom, 8)
                    Button(action: {
                            print("sign up bin tapped")
                        }) {
                            Text("See All")
                                .frame(minWidth: 0, maxWidth: geo.size.width * 0.3)
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.blue)
                                .padding(.vertical, 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 2)
                            )
                        }
                        .background(Color.white.opacity(0))
                        .cornerRadius(8)
                }.frame(maxHeight: .infinity, alignment: .leading)
            }
//            HStack {
//                Text(gameData.name ?? "").bold().foregroundColor(Color.white)
//                Spacer()
//                Image(systemName: "star.fill").resizable().frame(width: 16, height: 16).foregroundColor(Color.yellow)
//                Text(String(gameData.rating ?? 0.0)).foregroundColor(Color.white).font(.system(size: 14)).bold()
//            }.padding(12).frame(maxWidth: .infinity, alignment: .leading).background(Color.black.opacity(0.4).cornerRadius(12, corners: [.bottomLeft, .bottomRight]))
        }.padding(.horizontal, 12).padding(.top, 12)
    }
}
