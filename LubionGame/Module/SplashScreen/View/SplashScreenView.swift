import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.blue.ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "gamecontroller.fill").font(.system(size: 80)).foregroundColor(Color.white)
                        Text("Lubino Game").bold().foregroundColor(Color.white).font(.system(size: 22))
                    }
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
