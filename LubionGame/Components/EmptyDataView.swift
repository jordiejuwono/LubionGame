import SwiftUI

struct EmptyDataView: View {
    var emptyText: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(emptyText).font(.system(size: 22)).foregroundColor(Color.gray).bold().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).multilineTextAlignment(.center)
        }
    }
}
