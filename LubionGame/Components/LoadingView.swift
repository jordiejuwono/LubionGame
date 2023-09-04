import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Spacer().frame(height: 6)
            Text("Loading").bold().font(.system(size: 16)).foregroundColor(Color.gray.opacity(0.8))
        }
    }
}
