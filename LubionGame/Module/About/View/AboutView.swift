import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                Image("jordie-juwono").resizable().scaledToFill().frame(width: 200, height: 200).cornerRadius(12).clipped().padding(.top, 100)
                Text("Jordie Juwono").font(.system(size: 22)).bold()
                Text(verbatim: "jordie.juwono96@gmail.com").font(.system(size: 12)).bold().foregroundColor(Color.gray)
            }
        }
    }
}
